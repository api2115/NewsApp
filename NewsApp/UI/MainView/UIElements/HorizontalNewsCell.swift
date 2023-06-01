//
//  HorizontalNewsCell.swift
//  NewsApp
//
//  Created by Adam Pilarski on 01/06/2023.
//

import Foundation
import UIKit
import Combine

class HorizontalNewsCell: UICollectionViewCell, UIGestureRecognizerDelegate {
    //MARK: - Variables
    static let identifier = "NewsTile"
    var cancellable: AnyCancellable?
    var news: News?
    
    //MARK: - UIElelments
    let imageView = UIImageView()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.numberOfLines = 0
        return label
    }()
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 11)
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.boldSystemFont(ofSize: 10)
        return label
    }()
    
    let authorIcon: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "ProfileIcon")
        return iv
    }()
    
    let heartIcon: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "heart")
        iv.tintColor = .red
        return iv
    }()
    
    //MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        layer.cornerRadius = 20
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cancellable?.cancel()
    }
    
    //MARK: - Bind
    func bind(to viewModel: MainViewModel, index: Int) {
        cancellable = viewModel.$news
            .receive(on: DispatchQueue.main)
            .sink { [weak self] responseData in
                guard let self = self else { return }
                guard index < responseData.count else { return }
                
                let data = responseData[index]
                news = data
                let imageURL = URL(string: data.urlToImage ?? "https://static.remove.bg/sample-gallery/graphics/bird-thumbnail.jpg")
                self.imageView.sd_setImage(with: imageURL)
                titleLabel.text = data.title
                authorLabel.text = data.author
                
                let publishedDateString = data.publishedAt ?? "1970-01-01T01:01:01Z"
                dateLabel.text = publishedDateString.dateFormater()
                
                if checkIfNewsInMyFeed(item: data) {
                    heartIcon.image = UIImage(systemName: "heart.fill")
                    heartIcon.tintColor = .red
                } else {
                    heartIcon.image = UIImage(systemName: "heart")
                }
                
                setUpUI()
                
            }
    }
    
    
    //MARK: - Setup functions
    private func setUpUI() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(authorIcon)
        authorIcon.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(authorLabel)
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(heartIcon)
        heartIcon.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 120),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            
            authorIcon.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            authorIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            authorIcon.heightAnchor.constraint(equalToConstant: 30),
            authorIcon.widthAnchor.constraint(equalToConstant: 30),
            
            authorLabel.topAnchor.constraint(equalTo: authorIcon.topAnchor),
            authorLabel.leftAnchor.constraint(equalTo: authorIcon.rightAnchor, constant: 10),
            authorLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6),
            
            dateLabel.bottomAnchor.constraint(equalTo: authorIcon.bottomAnchor),
            dateLabel.leftAnchor.constraint(equalTo: authorIcon.rightAnchor, constant: 10),
            
            heartIcon.centerYAnchor.constraint(equalTo: authorIcon.centerYAnchor),
            heartIcon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            
        ])
        
    }

    private func checkIfNewsInMyFeed(item: News) -> Bool {
        return FeedManager.shared.getAllItems().contains { $0.title == item.title}
    }
    
    
}
