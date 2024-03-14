//
//  UIViewController+Ext.swift
//  GHFollowers
//
//  Created by Zachary on 14/3/24.
//

import UIKit

extension UIViewController {
    
    func presentCustomAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = CustomAlertViewController(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
}
