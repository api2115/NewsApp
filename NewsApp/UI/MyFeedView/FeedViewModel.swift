//
//  FeedViewModel.swift
//  NewsApp
//
//  Created by Adam Pilarski on 30/05/2023.
//

import Foundation

class FeedViewModel: ObservableObject {
    
    //MARK: - Input
    struct Input {
        let addNews: ((News)->Void)
        let addFeedNews: ((MyFeedNews)->Void)
    }
    //MARK: - Output
    struct Output {
        let onNewsUpdated: (()->Void)?
    }
    
    //MARK: - Variales
    var output: Output?
    private(set) var input: Input?
    
    @Published private(set) var feedNews: [MyFeedNews] = [] {
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
            },
            addFeedNews: { [weak self] MyFeedNews in
                self?.addToFeed(news: MyFeedNews)
            }
        )
    }
    
    private func addToFeed(news: News) {
        FeedManager.shared.createItem(news: news)
    }
    
    private func addToFeed(news: MyFeedNews) {
        FeedManager.shared.createItem(news: news)
    }
    
    public func fetchFeed() {
        self.feedNews = FeedManager.shared.getAllItems()
    }
    
    public func deleteFeedNews(news: News) {
        FeedManager.shared.deleteItem(item: news)
        fetchFeed()
    }
    
    public func deleteFeedNews(news: MyFeedNews) {
        FeedManager.shared.deleteItem(item: news)
        fetchFeed()
    }
    
    
}
