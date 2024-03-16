//
//  CustomTabBarController.swift
//  GHFollowers
//
//  Created by Zachary on 17/3/24.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemGreen
        viewControllers = [createSearchNavigationController(), createFavouritesNavigationController()]

    }
    
    func createSearchNavigationController() -> UINavigationController {
        let searchVC = SearchViewController()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        return UINavigationController(rootViewController: searchVC)
    }
    
    func createFavouritesNavigationController() -> UINavigationController {
        let favouritesListVC = FavouritesListViewController()
        favouritesListVC.title = "Favourites"
        favouritesListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: favouritesListVC)
    }
    
}
