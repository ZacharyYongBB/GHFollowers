//
//  CustomItemInfoViewController.swift
//  GHFollowers
//
//  Created by Zachary on 16/3/24.
//

import UIKit

protocol itemInfoVCDelegate: AnyObject {
    func didTapGitHubProfile(user: UserModel)
    func didTapGetFollowers(user: UserModel)
}

class CustomItemInfoViewController: UIViewController {
    
    let stackView = UIStackView()
    let itemInfoView1 = CustomItemInfoView()
    let itemInfoView2 = CustomItemInfoView()
    let actionButton = CustomButton()
    
    var user: UserModel!
    weak var delegate: itemInfoVCDelegate!
    
    init(user: UserModel!) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundView()
        configureActionButton()
        layoutUI()
        configureStackView()
    }
    
    func configureBackgroundView() {
        view.layer.cornerRadius = 18
        view.backgroundColor = .secondarySystemBackground
    }
    
    private func configureStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        stackView.addArrangedSubview(itemInfoView1)
        stackView.addArrangedSubview(itemInfoView2)
    }
    
    @objc func actionButtonTapped() {
        
    }
    
    private func configureActionButton() {
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    }
    
    private func layoutUI() {
        view.addSubviews(stackView, actionButton)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
    
}
