//
//  ErrorMessage.swift
//  GHFollowers
//
//  Created by Zachary on 14/3/24.
//

import Foundation

enum ErrorMessage: String, Error {
    case invalidUsername = "This username created an invalid request. Please try again 🥵"
    case unableToComplete = "Unable to complete your request. Please check your internet connection"
    case invalidResponse = "Invalid response from server. Please try again"
    case invalidData = "The data received from the server was invalid. Please try again"
}
