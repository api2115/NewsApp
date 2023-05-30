//
//  DetailedViewController.swift
//  NewsApp
//
//  Created by Adam Pilarski on 29/05/2023.
//

import UIKit

class DetailedViewController: UIViewController {
    
    //MARK: - UIElements
    
    let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        button.tintColor = .white
        
        return button
    }()
    
    let coverImage: UIImageView = {
        let iv = UIImageView()
        
        return iv
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        
        return label
    }()
    
    let contentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textColor = .black
        
        return label
    }()
    
    let news: News
    //MARK: - Initializer
    init(_ news: News) {
        self.news = news
        let imageURL = URL(string: news.urlToImage ?? "https://static.remove.bg/sample-gallery/graphics/bird-thumbnail.jpg")
        self.coverImage.sd_setImage(with: imageURL)
        
        titleLabel.text = news.title
        contentLabel.text = news.content
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        
        backButton.addTarget(self, action: #selector(backButtonTap), for: .touchUpInside)
        
        
    }
    
    //MARK: - SetUpFunctions
    
    private func setUpUI() {
        self.view.backgroundColor = UIColor(named: "DefaultColor")
        addToView(coverImage)
        addToView(backButton)
        addToView(titleLabel)
        addToView(contentLabel)
        
        NSLayoutConstraint.activate([
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
            contentLabel.topAnchor.constraint(equalTo: coverImage.bottomAnchor, constant: 30)
            
        ])
    }
    

    
}
