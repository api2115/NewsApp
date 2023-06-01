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
                delegate?.passData(data: news!, tapCase: .removeFromFeed)
                heartIcon.image = UIImage(systemName: "heart")
            } else {
                delegate?.passData(data: feedNews!, tapCase: .removeFromFeed)
                heartIcon.removeFromSuperview()
            }
        } else {
            if news != nil {
                delegate?.passData(data: news!, tapCase: .addToFeed)
            } else {
                delegate?.passData(data: feedNews!, tapCase: .addToFeed)
            }
            heartIcon.image = UIImage(systemName: "heart.fill")
        }
    }
    
    func setUpTargets() {
        backButton.addTarget(self, action: #selector(backButtonTap), for: .touchUpInside)
        heartIcon.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleHeartIconTap))
        heartIcon.addGestureRecognizer(gestureRecognizer)
    }
    
    //MARK: - Miscellaneous
    
    func addToView(_ element: UIView) {
        self.view.addSubview(element)
        element.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func checkIfNewsInMyFeed(item: News) -> Bool {
        return FeedManager.shared.getAllItems().contains { $0.title == item.title}
    }
    
    //MARK: - Constraints
    func makeDetailedViewConstraints() -> [NSLayoutConstraint] {
        [
            coverImage.topAnchor.constraint(equalTo: self.view.topAnchor),
            coverImage.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            coverImage.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.4),
            
            backButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50),
            backButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            
            titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            titleLabel.bottomAnchor.constraint(equalTo: coverImage.bottomAnchor, constant: -30),
            titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15),
            
            contentLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            contentLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15),
            contentLabel.topAnchor.constraint(equalTo: coverImage.bottomAnchor, constant: 30),
            
            heartIcon.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15),
            heartIcon.centerYAnchor.constraint(equalTo: backButton.centerYAnchor)
            
        ]
    }
    
}
