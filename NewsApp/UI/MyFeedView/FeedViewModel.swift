//
//  FeedViewModel.swift
//  NewsApp
//
//  Created by Adam Pilarski on 30/05/2023.
//

import Foundation

class FeedViewModel {
    
    //MARK: - Input
    struct Input {
        let addNews: ((News)->Void)
    }
    //MARK: - Output
    struct Output {
        let onNewsUpdated: (()->Void)?
    }
    
    //MARK: - Variales
    var output: Output?
    private(set) var input: Input?
    
    private(set) var feedNews: [MyFeedNews] = [] {
        didSet {
            output?.onNewsUpdated?()
        }
    }
    
    //MARK: - Initializer
    init() {
        fetchFeed()
        setUpInput()
    }
    
    //MARK: - Methods
    private func setUpInput() {
        input = .init(
            addNews: { [weak self] News in
                self?.addToFeed(news: News)
            }
        )
    }
    
    private func addToFeed(news: News) {
        FeedManager.shared.createItem(news: news)
    }
    
    public func fetchFeed() {
        self.feedNews = FeedManager.shared.getAllItems()
    }
    
}
