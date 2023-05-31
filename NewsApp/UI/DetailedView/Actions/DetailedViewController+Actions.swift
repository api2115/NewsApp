//
//  DetailedViewController+Actions.swift
//  NewsApp
//
//  Created by Adam Pilarski on 29/05/2023.
//

import UIKit

extension DetailedViewController {
    //MARK: - Button Functions
    @objc func backButtonTap() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleHeartIconTap() {
        if heartIcon.image == UIImage(systemName: "heart.fill") {
            if news != nil {
                delegate?.passData(data: news!, id: 3)
                heartIcon.image = UIImage(systemName: "heart")
            } else {
                delegate?.passData(data: feedNews!, id: 3)
                heartIcon.removeFromSuperview()
            }
        } else {
            if news != nil {
                delegate?.passData(data: news!, id: 2)
            } else {
                delegate?.passData(data: feedNews!, id: 2)
            }
            heartIcon.image = UIImage(systemName: "heart.fill")
        }
    }
    
    //MARK: - Miscellaneous
    
    func addToView(_ element: UIView) {
        self.view.addSubview(element)
        element.translatesAutoresizingMaskIntoConstraints = false
    }
    
}
