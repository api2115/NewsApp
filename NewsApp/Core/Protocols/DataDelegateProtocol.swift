//
//  HorizontalScrollDelegate.swift
//  NewsApp
//
//  Created by Adam Pilarski on 29/05/2023.
//

import Foundation

enum tapCase {
    case detailedViewTap
    case addToFeed
    case removeFromFeed
}

protocol DataDelegateProtocol: AnyObject {
    func passData(data: News, tapCase: tapCase)
    func passData(data: MyFeedNews, tapCase: tapCase)
}

extension DataDelegateProtocol {
    func passData(data: MyFeedNews, tapCase: tapCase) {
        
    }
    
    func passData(data: News, tapCase: tapCase) {
        
    }
}
