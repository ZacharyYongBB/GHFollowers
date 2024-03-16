//
//  FavouritesListViewController.swift
//  GHFollowers
//
//  Created by Zachary on 13/3/24.
//

import UIKit

class FavouritesListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        
        PersistenceManager.retrieveFavourites { result in
            switch result {
            case .success(let favourites):
                print(favourites)
            case .failure(let error):
                break
            }
        }
    }
    
}
