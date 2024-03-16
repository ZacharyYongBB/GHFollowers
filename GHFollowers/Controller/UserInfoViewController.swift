//
//  UserInfoViewController.swift
//  GHFollowers
//
//  Created by Zachary on 16/3/24.
//

import UIKit

class UserInfoViewController: UIViewController {
    
    let headerView = UIView()
    let itemView1 = UIView()
    let itemView2 = UIView()
    let dateLabel = CustomBodyLabel(textAlignment: .center)
    var itemViews: [UIView] = []
    
    var username: String = ""
    
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
                    self.add(childVC: CustomUserInfoHeaderViewController(user: user), to: self.headerView)
                    self.add(childVC: CustomRepoItemViewController(user: user), to: self.itemView1)
                    self.add(childVC: CustomFollowItemViewController(user: user), to: self.itemView2)
                    self.dateLabel.text = "GitHub Since: \(user.createdAt.convertToDisplayFormat())"
                }
            case .failure(let error):
                self.presentCustomAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
            }
        }
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
