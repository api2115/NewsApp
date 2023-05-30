//
//  MyFeedNews+CoreDataProperties.swift
//  NewsApp
//
//  Created by Adam Pilarski on 30/05/2023.
//
//

import Foundation
import CoreData


extension MyFeedNews {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MyFeedNews> {
        return NSFetchRequest<MyFeedNews>(entityName: "MyFeedNews")
    }

    @NSManaged public var author: String?
    @NSManaged public var title: String?
    @NSManaged public var desc: String?
    @NSManaged public var urlToImage: String?
    @NSManaged public var publishedAt: String?
    @NSManaged public var content: String?

}

extension MyFeedNews : Identifiable {

}
