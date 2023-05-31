//
//  APIService.swift
//  NewsApp
//
//  Created by Adam Pilarski on 31/05/2023.
//

import Alamofire
import Foundation

enum ApiServiceError: Error{
    case serverError(String = "Invalid api key")
    case urlSessionError(String)
    case invalidResponse(String = "Invalid response from server")
    case decodingError(String = "Error parsing server response")
}

protocol Service {
    func makeRequest<T: Codable>(with request: URLRequest, completion: @escaping(T?, ApiServiceError?)->Void)
}

class APIService: Service {
    func makeRequest<T: Codable>(with request: URLRequest, completion: @escaping (T?, ApiServiceError?) -> Void) {
        AF.request(request).responseData { response in
            switch response.result {
            case .success(let data):
                if let resp = response.response, resp.statusCode > 299 {
                    completion(nil, .serverError())
                    return
                }
                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    completion(result, nil)
                } catch let err {
                    print(err)
                    completion(nil, .decodingError())
                }
                
            case .failure(let error):
                completion(nil, .urlSessionError(error.localizedDescription))
            }
        }
    }
}
