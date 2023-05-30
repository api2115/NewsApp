//
//  Endpoint.swift
//  NewsApp
//
//  Created by Adam Pilarski on 25/05/2023.
//

import Foundation

enum Endpoint {
    
    case fetchNews(url: String, category: String = "general", language: String = "us")
    
    var request: URLRequest? {
        guard let url = self.url else {return nil}
        
        var request = URLRequest(url: url)
        request.httpMethod = self.httpMethod
        
        return request
    }
    
    private var url: URL? {
        var components = URLComponents()
        components.scheme = Constants.scheme
        components.host = Constants.baseURL
        components.port = Constants.port
        components.path = self.path
        components.queryItems = self.queryItems
        return components.url
    }
    
    private var path: String {
        switch self {
        case .fetchNews(let url, _, _):
            return url
        }
    }
    
    private var queryItems: [URLQueryItem] {
        switch self {
        case .fetchNews(_, let category, let language):
            return [
                URLQueryItem(name: "country", value: language),
                URLQueryItem(name: "category", value: category),
                URLQueryItem(name: "apiKey", value: Constants.apiKey)
            ]
        }
    }
    
    private var httpMethod: String {
        switch self {
        case .fetchNews:
            return HTTP.Method.get.rawValue
        }
    }
    
    
    
}
