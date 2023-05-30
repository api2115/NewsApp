//
//  NewsService.swift
//  NewsApp
//
//  Created by Adam Pilarski on 25/05/2023.
//

import Foundation

enum NewsServiceError: Error{
    case serverError(NewsError)
    case unknown(String = "An unknown error occured")
    case decodingError(String = "Error parsing server response")
}

class NewsService {
    
    static func fetchNews(with endpoint: Endpoint,
                          completion: @escaping (Result<[News], NewsServiceError>)->Void) {
        guard let request = endpoint.request else { return }
        
        URLSession.shared.dataTask(with: request) { data, resp, error in
            if let error = error {
                completion(.failure(.unknown(error.localizedDescription)))
                return
            }
            
            if let resp = resp as? HTTPURLResponse, resp.statusCode != 200 {
                do {
                    let newsError = try JSONDecoder().decode(NewsError.self, from: data ?? Data())
                    completion(.failure(.serverError(newsError)))
                } catch let err {
                    completion(.failure(.unknown()))
                    print(err.localizedDescription)
                }
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let newsData = try decoder.decode(NewsArray.self, from: data)
                    completion(.success(newsData.articles))
                } catch let err {
                    completion(.failure(.decodingError()))
                    print(err)
                }
            } else {
                completion(.failure(.unknown()))
            }
            
        }.resume()
        
        
    }
    
    
}
