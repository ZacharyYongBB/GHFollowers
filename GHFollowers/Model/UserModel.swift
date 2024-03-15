//
//  UserModel.swift
//  GHFollowers
//
//  Created by Zachary on 14/3/24.
//

import Foundation

struct UserModel: Codable {
    let login: String
    let avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    let publicRepos: Int
    let publicGists: Int
    let htmlUrl: String
    let following: Int
    let followers: Int
    let createdAt: String
}
