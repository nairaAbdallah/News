//
//  NewsManager.swift
//  News
//
//  Created by Naira Bassam on 26/08/2021.
//

import Foundation

final class NewsManager {
   
    static let shared = NewsManager()

    private init() {}
    
    public func performRequest(completion: @escaping (Result<[Articles], Error>) -> Void) {
      
        guard let url = K.url else {return}
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            else if let safeData = data {
                do {
                    let result = try JSONDecoder().decode(NewsModel.self, from: safeData)
                    completion(.success(result.articles))
                }catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    //Search
    public func search(with query: String, completion: @escaping (Result<[Articles], Error>) -> Void) {
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        let urlString = K.urlForSearch + query
        guard let url = URL(string: urlString) else {return}
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            else if let safeData = data {
                do {
                    let result = try JSONDecoder().decode(NewsModel.self, from: safeData)
                    completion(.success(result.articles))
                }catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}
