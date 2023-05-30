//
//  NewsTile.swift
//  NewsApp
//
//  Created by Adam Pilarski on 26/05/2023.
//

import UIKit
import SDWebImage

class NewsTile: UIView {

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
    var item: News
    init(_ item: News) {
        self.item = item
        let imageURL = URL(string: item.urlToImage ?? "https://static.remove.bg/sample-gallery/graphics/bird-thumbnail.jpg")
        self.imageView.sd_setImage(with: imageURL)
        titleLabel.text = item.title
        authorLabel.text = item.author
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: item.publishedAt ?? "1970-01-01T01:01:01Z")
        dateFormatter.dateFormat = "dd MMM yyyy"
        dateLabel.text = dateFormatter.string(from: date!)

        super.init(frame: .zero)
        clipsToBounds = true
        layer.cornerRadius = 20
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 10
        self.setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
}
