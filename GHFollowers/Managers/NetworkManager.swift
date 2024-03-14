//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Zachary on 14/3/24.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    let baseUrl = "https://api.github.com/users/"
    
    
    private init() {}
    
    func getFollowers(username: String, page: Int, completed: @escaping([Follower]?, ErrorMessage?) -> Void) {
        let endPoint = baseUrl + "\(username)/followers?per_page=50&page=\(page)"
        
        guard let url = URL(string: endPoint) else {
            completed(nil, .invalidUsername)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(nil, .unableToComplete)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(nil, .invalidResponse)
                return
            }
            
            guard let data = data else {
                completed(nil, .invalidData)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completed(followers, nil)
            } catch {
                completed(nil, .invalidData)
            }
        }
        
        task.resume()
    }
}