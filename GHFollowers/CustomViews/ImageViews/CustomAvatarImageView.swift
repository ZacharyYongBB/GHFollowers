//
//  CustomAvatarImageView.swift
//  GHFollowers
//
//  Created by Zachary on 14/3/24.
//

import UIKit

class CustomAvatarImageView: UIImageView {

    let cache = NetworkManager.shared.cache
    let placeholderImage = ImagesNamed.placeHolder
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
