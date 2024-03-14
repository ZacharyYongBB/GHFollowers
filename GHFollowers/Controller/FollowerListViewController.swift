//
//  FollowerViewController.swift
//  GHFollowers
//
//  Created by Zachary on 14/3/24.
//

import UIKit

class FollowerListViewController: UIViewController {
    
    var username: String? = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        NetworkManager.shared.getFollowers(username: username ?? "", page: 1) { followers, errorMessage in
            guard let followers = followers else {
                self.presentCustomAlertOnMainThread(title: "Something Went wrong", message: errorMessage?.rawValue ?? "Error, please try again", buttonTitle: "OK")
                return
            }
            
            print("Followers.count = \(followers.count)")
            print("Followers = \(followers)")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
