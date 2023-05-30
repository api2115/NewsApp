//
//  MainHeaderView.swift
//  NewsApp
//
//  Created by Adam Pilarski on 26/05/2023.
//

import UIKit

class MainHeaderView: UIView {
    
    // MARK: - UI Components
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.text = "Discover"
        return label
    }()
    
    lazy var languageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "gear"), for: .normal)
        button.tintColor = .red
        return button
    }()
    
    lazy var myFeedButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("My Feed", for: .normal)
        button.tintColor = .gray
        return button
    }()

    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        
        backgroundColor = .white
        
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowOpacity = 1
        layer.shadowColor = UIColor(named: "HeaderShadowColor")?.cgColor
        layer.shadowRadius = 35
        
        addSubview(titleLabel)
        addSubview(languageButton)
        addSubview(myFeedButton)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        languageButton.translatesAutoresizingMaskIntoConstraints = false
        myFeedButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -19),
            
            languageButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            languageButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),

            myFeedButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            myFeedButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
        ])
        
    }

}
