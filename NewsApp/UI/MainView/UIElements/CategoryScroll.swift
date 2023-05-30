//
//  CategoryScroll.swift
//  NewsApp
//
//  Created by Adam Pilarski on 29/05/2023.
//

import UIKit

class CategoryScroll: UIView {
    //MARK: - variables
    private let categories = ["general", "business", "entertainment", "health", "science", "sports", "technology"]
    var selectedButton: UIButton?
    var viewModel: MainViewModel
    
    //MARK: - UIElements
    lazy var scrollView = UIScrollView()

    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        return stack
    }()
    
    //MARK: - Initializer
    init(_ viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup functions
    private func setUpUI() {
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)
        self.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
        ])
        renderUI()
    }
    
    private func renderUI() {
        for category in categories {
            
            let categoryButton: UIButton = {
                let button = UIButton(type: .system)
                button.tintColor = .gray
                button.setTitle(category, for: .normal)
                button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
                button.contentHorizontalAlignment = .center
                button.isUserInteractionEnabled = true
                return button
            }()
            if categoryButton.currentTitle == "general" {
                categoryButton.tintColor = .black
                selectedButton = categoryButton
            }
            stackView.addArrangedSubview(categoryButton)
            categoryButton.addTarget(self, action: #selector(categoryPick), for: .touchUpInside)
            
        }
    }
    
    @objc func categoryPick(sender: UIButton) {
        selectedButton?.tintColor = .gray
        selectedButton = sender
        sender.tintColor = .black
        self.viewModel.selectedCategory = sender.currentTitle!
        self.viewModel.fetchNews(category: sender.currentTitle!, language: self.viewModel.selectedLanguage)
    }
    
    
    
    
}
