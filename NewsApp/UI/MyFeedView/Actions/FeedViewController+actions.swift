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
    
    //MARK: - Data
    func setUpModelOutput() {
        self.viewModel.output = .init(
            onNewsUpdated: { [weak self] in
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        )
    }
    
    //MARK: - Button Functions
    @objc func backButtonTap() {
        delegate?.didDismiss()
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Miscellaneous
    func addToView(_ element: UIView) {
        self.view.addSubview(element)
        element.translatesAutoresizingMaskIntoConstraints = false
    }
    
    //MARK: - Constraints
    func makeFeedViewContsraints() -> [NSLayoutConstraint] {
        [
            headerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            headerView.topAnchor.constraint(equalTo: self.view.topAnchor),
            headerView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.15),
            headerView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
        ]
    }
}
