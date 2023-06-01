//
//  HorizontalScrollDelegate.swift
//  NewsApp
//
//  Created by Adam Pilarski on 29/05/2023.
//

import Foundation

enum TapCase {
    case detailedViewTap
    case addToFeed
    case removeFromFeed
}

protocol DataDelegateProtocol: AnyObject {
    func passData(data: News, tapCase: TapCase)
    func passData(data: MyFeedNews, tapCase: TapCase)
}

extension DataDelegateProtocol {
    func passData(data: MyFeedNews, tapCase: TapCase) {
        
    }
    
    func passData(data: News, tapCase: TapCase) {
        
    }
}
