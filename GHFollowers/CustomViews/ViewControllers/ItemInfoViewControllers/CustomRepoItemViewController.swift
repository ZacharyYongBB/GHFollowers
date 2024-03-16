//
//  CustomRepoItemViewController.swift
//  GHFollowers
//
//  Created by Zachary on 16/3/24.
//

import UIKit

class CustomRepoItemViewController: CustomItemInfoViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        itemInfoView1.set(itemInfoType: .repos, count: user.publicRepos)
        itemInfoView2.set(itemInfoType: .gists, count: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
    }
    
}
