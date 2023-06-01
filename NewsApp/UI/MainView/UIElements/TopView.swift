//
//  TopView.swift
//  NewsApp
//
//  Created by Adam Pilarski on 29/05/2023.
//

import UIKit

class TopView: UIView {
    
    weak var delegate: DataDelegateProtocol?
    
    //MARK: - UIElements
    private lazy var trendingLabel: UILabel = {
        let label = UILabel()
        label.text = "Trending news"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 225, height: 220)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.register(HorizontalNewsCell.self, forCellWithReuseIdentifier: "NewsTile")
        return collectionView
    }()

    var viewModel: MainViewModel
    //MARK: - Initializer
    init(frame: CGRect, viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        self.addSubview(trendingLabel)
        self.addSubview(collectionView)
        
        trendingLabel.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            collectionView.widthAnchor.constraint(equalTo: self.widthAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 220),
            
            trendingLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20),
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension TopView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsTile", for: indexPath) as! HorizontalNewsCell
        cell.bind(to: self.viewModel, index: indexPath.row)
        
        cell.isUserInteractionEnabled = true
        let GestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showDetailedView))
        cell.addGestureRecognizer(GestureRecognizer)
        
        return cell
    }
    
    
    @objc private func showDetailedView(sender: UITapGestureRecognizer) {
        guard let view = sender.view as? HorizontalNewsCell else {
            return
        }
        let tapLocation = sender.location(in: view)
        let news = view.news!
        if view.imageView.frame.contains(tapLocation) {
            delegate?.passData(data: news, tapCase: .detailedViewTap)
        }
        if view.heartIcon.frame.contains(tapLocation){
            if view.heartIcon.image == UIImage(systemName: "heart.fill") {
                delegate?.passData(data: news, tapCase: .removeFromFeed)
                view.heartIcon.image = UIImage(systemName: "heart")
            } else {
                delegate?.passData(data: news, tapCase: .addToFeed)
                view.heartIcon.image = UIImage(systemName: "heart.fill")
            }
        }
        
    }
    
}
