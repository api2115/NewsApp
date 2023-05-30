//
//  FeedViewController+actions.swift
//  NewsApp
//
//  Created by Adam Pilarski on 30/05/2023.
//

import UIKit

extension FeedViewController {
    
    //MARK: - Button Functions
    @objc func backButtonTap() {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Miscellaneous
    func addToView(_ element: UIView) {
        self.view.addSubview(element)
        element.translatesAutoresizingMaskIntoConstraints = false
    }
}
