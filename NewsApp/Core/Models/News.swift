//
//  News.swift
//  NewsApp
//
//  Created by Adam Pilarski on 25/05/2023.
//

import Foundation

struct NewsArray: Decodable {
    let articles: [News]
}

struct News: Codable {
    let source: Source
    let author: String?
    let title: String?
    let description: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

struct Source: Codable {
    let id: String?
    let name: String?
}



