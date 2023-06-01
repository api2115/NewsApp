//
//  MainViewModel.swift
//  NewsApp
//
//  Created by Adam Pilarski on 25/05/2023.
//

import Foundation
import Combine

class MainViewModel: ObservableObject {
    //MARK: - Output
    struct Output {
        var onNewsUpdated: (()->Void)?
        var onErrorMessage: ((NewsServiceError)->Void)?
    }
    
    //MARK: - Variables
    let service = APIService()
    var output: Output?
    @Published private(set) var news: [News] = [] {
        didSet {
            output?.onNewsUpdated?()
        }
    }
    
    var selectedCategory = "general"
    var selectedLanguage = "us"

    //MARK: - Initializer
    init() {
        self.fetchNews(category: selectedCategory, language: selectedLanguage)
    }
    
    //MARK: - Methods
    public func fetchNews(category: String, language: String) {
        
        let endpoint = Endpoint.fetchNews(url: "/v2/top-headlines", category: category, language: language).request!
        
        self.service.makeRequest(with: endpoint) { (news: NewsArray?, error) in
            if let error = error {
                print(error)
                return
            }
            self.news = news?.articles ?? []
        }
        
    }
    
}
