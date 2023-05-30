//
//  FeedController.swift
//  NewsApp
//
//  Created by Adam Pilarski on 30/05/2023.
//

import CoreData
import UIKit

class FeedManager {
    private let context : NSManagedObjectContext
    
    static let shared = FeedManager()
    
    init() {
        self.context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    
    func getAllItems() -> [MyFeedNews] {
        var models = [MyFeedNews]()
        let req = MyFeedNews.fetchRequest()
        do {
            models = try context.fetch(req)
        }
        catch {
            print(error)
        }
        return models
    }
    
    func createItem(news: News) {
        let item = MyFeedNews(context: context)
        item.author = news.author
        item.content = news.content
        item.desc = news.description
        item.publishedAt = news.publishedAt
        item.title = news.title
        item.urlToImage = news.urlToImage
        do {
            try context.save()
        }
        catch {
            print(error)
        }
    }
    
    
    func deleteItem(item: MyFeedNews) {
        context.delete(item)
        do {
            try context.save()
        }
        catch {
            print(error)
        }
    }
    
    func deleteAllItems() -> [MyFeedNews] {
        let models = getAllItems()
        for model in models {
            context.delete(model)
        }
        do {
            try context.save()
        }
        catch {
            print(error)
        }
        return []
    }
    
}
