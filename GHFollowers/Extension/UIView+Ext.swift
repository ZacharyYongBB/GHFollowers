//
//  UIView+Ext.swift
//  GHFollowers
//
//  Created by Zachary on 17/3/24.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
