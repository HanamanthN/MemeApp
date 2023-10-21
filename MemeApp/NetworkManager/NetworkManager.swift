//
//  NetworkManager.swift
//  MemeApp
//
//  Created by Hanamanth Nagonde on 18/10/23.
//

import Swift
import Foundation

enum NetworkError: Error {
    case invalidURL
    case dataNotFound
    case dataParseError
}

protocol NetworkManagerProtocol {
    func fetch<T: Codable>(url: String, type: T.Type, completion: @escaping (Result<T, Error>) -> Void)
}

class NetworkManager: NetworkManagerProtocol {
    static let shared = NetworkManager()
    
    func fetch<T: Codable>(url: String, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            
            guard let apiData = data else {
                completion(.failure(NetworkError.dataNotFound))
                return
            }
            
            do {
                let apiResponse = try JSONDecoder().decode(type.self, from: apiData)
                completion(.success(apiResponse))
            } catch {
                completion(.failure(NetworkError.dataNotFound))
            }
        }
        task.resume()
    }
}
