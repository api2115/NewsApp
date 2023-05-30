//
//  TopView.swift
//  NewsApp
//
//  Created by Adam Pilarski on 29/05/2023.
//

import UIKit

class TopView: UIView {
    
    //MARK: - UIElements
    private lazy var trendingLabel: UILabel = {
        let label = UILabel()
        label.text = "Trending news"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()

    lazy var horizontalScrol = TopNewsView()

    //MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(trendingLabel)
        self.addSubview(horizontalScrol)
        
        trendingLabel.translatesAutoresizingMaskIntoConstraints = false
        horizontalScrol.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            horizontalScrol.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            horizontalScrol.widthAnchor.constraint(equalTo: self.widthAnchor),
            horizontalScrol.heightAnchor.constraint(equalToConstant: 220),
            
            trendingLabel.topAnchor.constraint(equalTo: horizontalScrol.bottomAnchor, constant: 20),
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
