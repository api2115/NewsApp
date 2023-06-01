//
//  FeedViewController+actions.swift
//  NewsApp
//
//  Created by Adam Pilarski on 30/05/2023.
//

import UIKit

extension FeedViewController: DataDelegateProtocol {
    //MARK: - Protocol
    func passData(data: MyFeedNews, id: Int) {
        if id == 2 {
            viewModel.input?.addFeedNews(data)
        } else if id == 3 {
            viewModel.deleteFeedNews(news: data)
        }
    }
    
    //MARK: - Button Functions
    @objc func backButtonTap() {
        delegate?.didDismiss()
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Miscellaneous
    func addToView(_ element: UIView) {
        self.view.addSubview(element)
        element.translatesAutoresizingMaskIntoConstraints = false
    }
}
