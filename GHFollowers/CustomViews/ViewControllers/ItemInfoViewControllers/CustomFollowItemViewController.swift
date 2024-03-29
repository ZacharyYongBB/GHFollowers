//
//  CustomFollowItemViewController.swift
//  GHFollowers
//
//  Created by Zachary on 16/3/24.
//

import UIKit

class CustomFollowItemViewController: CustomItemInfoViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        itemInfoView1.set(itemInfoType: .followers, count: user.followers)
        itemInfoView2.set(itemInfoType: .following, count: user.following)
        actionButton.set(color: .systemTeal, title: "Get Followers", systemImageName: "person.3")
    }
    
    override func actionButtonTapped() {
        delegate.didTapGetFollowers(user: user)
    }
    
}

