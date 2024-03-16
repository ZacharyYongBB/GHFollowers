//
//  PersistenceManager.swift
//  GHFollowers
//
//  Created by Zachary on 16/3/24.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {
    
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let favourites = "favourites"
    }
    
    static func updateWith(favourite: FollowerModel, actionType: PersistenceActionType, completed: @escaping (ErrorMessage?) -> Void) {
        retrieveFavourites { result in
            switch result {
            case .success(let favourites) :
                var retrievedFavourites = favourites
                
                switch actionType {
                case .add:
                    guard !retrievedFavourites.contains(favourite) else {
                        completed(.alreadyInFavourites)
                        return
                    }
                    retrievedFavourites.append(favourite)
                    
                case .remove:
                    retrievedFavourites.removeAll {
                        $0.login == favourite.login
                    }
                }
                
                completed(save(favourites: retrievedFavourites))
                
            case .failure(let error) :
                completed(error)
            }
        }
    }
    
    static func retrieveFavourites(completed: @escaping (Result<[FollowerModel], ErrorMessage>) -> Void) {
        guard let favouritesData = defaults.object(forKey: Keys.favourites) as? Data else {
            completed(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favourites = try decoder.decode([FollowerModel].self, from: favouritesData)
            completed(.success(favourites))
        } catch {
            completed(.failure(.unableToFavourite))
        }
        
    }
    
    static func save(favourites: [FollowerModel]) -> ErrorMessage? {
        
        do {
            let encoder = JSONEncoder()
            let encodedFavourites = try encoder.encode(favourites)
            defaults.set(encodedFavourites, forKey: Keys.favourites)
            return nil
        } catch {
            return .unableToFavourite
        }
    }
    
}
