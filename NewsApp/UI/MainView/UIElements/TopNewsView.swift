//
//  HorizontalScrolView.swift
//  NewsApp
//
//  Created by Adam Pilarski on 26/05/2023.
//

import UIKit

class TopNewsView: UIView {
    //MARK: - Protocol
    weak var delegate: DataDelegateProtocol?

    //MARK: - Variables
    var dataSource: [News] = [] {
        didSet {
            renderUI()
        }
    }
    
    //MARK: - UIElements
    lazy var scrollView = UIScrollView()

    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        return stack
    }()
        
    //MARK: - Initializer
    init() {
        super.init(frame: .zero)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - SetUp functions
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
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
        ])
        renderUI()
    }
    
    private func renderUI() {
        for arrangedSubview in stackView.arrangedSubviews {
            stackView.removeArrangedSubview(arrangedSubview)
            arrangedSubview.removeFromSuperview()
        }
        
        for item in dataSource {
            let tile = NewsTile(item)
            tile.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                tile.widthAnchor.constraint(equalToConstant: 225)
            ])
            stackView.addArrangedSubview(tile)
            tile.isUserInteractionEnabled = true
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showDetailedView))
            tile.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    @objc private func showDetailedView(sender: UITapGestureRecognizer) {
        guard let view = sender.view as? NewsTile else {
            return
        }
        let tapLocation = sender.location(in: view)
        let news = view.item
        if view.imageView.frame.contains(tapLocation) {
            delegate?.passData(data: news, id: 1)
        }
        if view.heartIcon.frame.contains(tapLocation){
            delegate?.passData(data: news, id: 2)
            view.heartIcon.image = UIImage(systemName: "heart.fill")
        }
        
        
        
    }
    
    
}
