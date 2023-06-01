//
//  DataFormater.swift
//  NewsApp
//
//  Created by Adam Pilarski on 01/06/2023.
//

import Foundation

extension String {
    func dateFormater() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: self) ?? Date(timeIntervalSince1970: 0)
        
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter.string(from: date)
    }
}
