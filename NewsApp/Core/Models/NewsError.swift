//
//  NewsError.swift
//  NewsApp
//
//  Created by Adam Pilarski on 25/05/2023.
//

import Foundation

struct NewsError: Decodable {
    let status: String
    let code: String
    let message: String
}
