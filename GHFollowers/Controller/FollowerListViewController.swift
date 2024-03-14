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
        
        NetworkManager.shared.getFollowers(username: username ?? "", page: 1) {result in
            
            switch result {
            case .success(let followers):
                print("Followers.count = \(followers.count)")
                print("Followers = \(followers)")
            case .failure(let error):
                self.presentCustomAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
            }
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
