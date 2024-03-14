//
//  UserModel.swift
//  GHFollowers
//
//  Created by Zachary on 14/3/24.
//

import Foundation

struct UserModel: Codable {
    var login: String
    var avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    var publicRepos: Int
    var publicGists: Int
    var htmlUrl: String
    var following: Int
    var followers: Int
    var createdAt: String
}
