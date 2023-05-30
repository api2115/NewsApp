//
//  MainViewModel.swift
//  NewsApp
//
//  Created by Adam Pilarski on 25/05/2023.
//

import Foundation

class MainViewModel {
    //MARK: - Output
    struct Output {
        var onNewsUpdated: (()->Void)?
        var onErrorMessage: ((NewsServiceError)->Void)?
    }
    
    //MARK: - Variables
    var output: Output?
    private(set) var news: [News] = [] {
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
        
        let endpoint = Endpoint.fetchNews(url: "/v2/top-headlines", category: category, language: language)
        
        NewsService.fetchNews(with: endpoint) { [weak self] result in
            switch result {
            case .success(let news):
                self?.news = news
            case .failure(let error):
                self?.output?.onErrorMessage?(error)
            }
        }
        
    }
    
}
