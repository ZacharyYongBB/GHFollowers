//
//  UserInfoViewController.swift
//  GHFollowers
//
//  Created by Zachary on 16/3/24.
//

import UIKit

protocol UserInfoVCDelegate: AnyObject {
    func didTapGitHubProfile(user: UserModel)
    func didTapGetFollowers(user: UserModel)
}

class UserInfoViewController: CustomDataLoadingViewController {
    
    let headerView = UIView()
    let itemView1 = UIView()
    let itemView2 = UIView()
    let dateLabel = CustomBodyLabel(textAlignment: .center)
    var itemViews: [UIView] = []
    
    var username: String = ""
    weak var delegate: FollowerListVCDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        layoutUI()
        getUserInfo()
    }
    
    func configureVC() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    func getUserInfo() {
        NetworkManager.shared.getUserInfo(username: username) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.configureUIElements(user: user)
                }
            case .failure(let error):
                self.presentCustomAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    func configureUIElements(user: UserModel) {
        let repoItemVC = CustomRepoItemViewController(user: user)
        repoItemVC.delegate = self
        let followerItemVC = CustomFollowItemViewController(user: user)
        followerItemVC.delegate = self
        
        self.add(childVC: CustomUserInfoHeaderViewController(user: user), to: self.headerView)
        self.add(childVC: repoItemVC, to: self.itemView1)
        self.add(childVC: followerItemVC, to: self.itemView2)
        self.dateLabel.text = "GitHub Since: \(user.createdAt.convertToMonthYearFormat())"
    }
    
    func layoutUI() {
        itemViews = [headerView, itemView1, itemView2, dateLabel]
        
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140
        
        for i in itemViews {
            view.addSubview(i)
            i.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                i.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                i.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            ])
        }
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemView1.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemView1.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemView2.topAnchor.constraint(equalTo: itemView1.bottomAnchor, constant: padding),
            itemView2.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemView2.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18),
        ])
    }
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
}

extension UserInfoViewController: UserInfoVCDelegate {
    func didTapGitHubProfile(user: UserModel) {
        guard let url = URL(string: user.htmlUrl) else {
            presentCustomAlertOnMainThread(title: "Invalid URL", message: "The url attached to this user isnt valid.", buttonTitle: "OK")
            return
        }
        presentSafariVC(url: url)
    }
    
    func didTapGetFollowers(user: UserModel) {
        guard user.followers != 0 else {
            presentCustomAlertOnMainThread(title: "No followers", message: "This user has no followers. 🥵", buttonTitle: "OK")
            return
        }
        delegate.didRequestFollowers(username: user.login)
        dismissVC()
    }
    
}
