//
//  HorizontalScrollDelegate.swift
//  NewsApp
//
//  Created by Adam Pilarski on 29/05/2023.
//

import Foundation

protocol DataDelegateProtocol: AnyObject {
    func passData(data: News, id: Int)
}
