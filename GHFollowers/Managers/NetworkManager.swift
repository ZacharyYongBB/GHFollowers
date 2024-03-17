//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Zachary on 14/3/24.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    private let baseUrl = "https://api.github.com/users/"
    let cache = NSCache<NSString, UIImage>()
    let decoder = JSONDecoder()
    
    
    private init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
    }
    /*
     
     @escaping Closure
     
     func getFollowers(username: String, page: Int, completed: @escaping(Result<[FollowerModel], ErrorMessage>) -> Void) {
     let endPoint = baseUrl + "\(username)/followers?per_page=50&page=\(page)"
     
     guard let url = URL(string: endPoint) else {
     completed(.failure(.invalidUsername))
     return
     }
     
     let task = URLSession.shared.dataTask(with: url) { data, response, error in
     if let _ = error {
     completed(.failure(.unableToComplete))
     return
     }
     
     guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
     completed(.failure(.unableToComplete))
     return
     }
     
     guard let data = data else {
     completed(.failure(.invalidData))
     return
     }
     
     do {
     let decoder = JSONDecoder()
     decoder.keyDecodingStrategy = .convertFromSnakeCase
     let followers = try decoder.decode([FollowerModel].self, from: data)
     completed(.success(followers))
     } catch {
     completed(.failure(.invalidData))
     }
     }
     
     task.resume()
     }
     */
    
    func getFollowers(username: String, page: Int) async throws -> [FollowerModel] {
        let endPoint = baseUrl + "\(username)/followers?per_page=50&page=\(page)"
        
        guard let url = URL(string: endPoint) else {
            throw ErrorMessage.invalidUsername
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw ErrorMessage.invalidResponse
        }
        
        do {
            return try decoder.decode([FollowerModel].self, from: data)
        } catch {
            throw ErrorMessage.invalidData
        }
        
    }
    
    
    func getUserInfo(username: String, completed: @escaping(Result<UserModel, ErrorMessage>) -> Void) {
        let endPoint = baseUrl + "\(username)"
        
        guard let url = URL(string: endPoint) else {
            completed(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .iso8601
                let user = try decoder.decode(UserModel.self, from: data)
                completed(.success(user))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
        
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard error == nil,
                  let response = response as? HTTPURLResponse, response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data) else {
                completed(nil)
                return
            }
            
            self?.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        
        task.resume()
    }
}
