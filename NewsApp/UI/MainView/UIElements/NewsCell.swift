//
//  NewsCell.swift
//  NewsApp
//
//  Created by Adam Pilarski on 25/05/2023.
//

import UIKit
import SDWebImage
import Combine

class NewsCell: UITableViewCell {

    //MARK: - Variables
    static let identifier = "NewsCell"
    var cancellable: AnyCancellable?
    
    //MARK: - UI Elements
    lazy var leftImageView = UIImageView()
    lazy var cellTitle = UILabel()
    lazy var dateLabel = UILabel()
    
    //MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cancellable?.cancel()
    }
    
    //MARK: - UI setup

    func bind(to viewModel: MainViewModel, index: Int) {
        cancellable = viewModel.$news
            .receive(on: DispatchQueue.main)
            .sink { [weak self] responseData in
                guard let self = self else { return }
                guard index < responseData.count else { return }
                
                let data = responseData[index]
                
                cellTitle.textColor = .black
                cellTitle.text = data.title
                cellTitle.font = UIFont.boldSystemFont(ofSize: 16)
                cellTitle.numberOfLines = 0

                let imageURL = URL(string: data.urlToImage ?? "https://static.remove.bg/sample-gallery/graphics/bird-thumbnail.jpg")
                self.leftImageView.sd_setImage(with: imageURL)

                self.leftImageView.layer.cornerRadius = 20
                self.leftImageView.clipsToBounds = true

                dateLabel.textColor = .gray
                let publishedDateString = data.publishedAt ?? "1970-01-01T01:01:01Z"
                dateLabel.text = publishedDateString.dateFormater()
                dateLabel.font = UIFont.boldSystemFont(ofSize: 14)

                setUpUI()
                
                
                
            }
    }
    
    func bind(to viewModel: FeedViewModel, index: Int) {
        cancellable = viewModel.$feedNews
            .receive(on: DispatchQueue.main)
            .sink { [weak self] responseData in
                guard let self = self else { return }
                guard index < responseData.count else { return }
                
                let data = responseData[index]
                
                cellTitle.textColor = .black
                cellTitle.text = data.title
                cellTitle.font = UIFont.boldSystemFont(ofSize: 16)
                cellTitle.numberOfLines = 0

                let imageURL = URL(string: data.urlToImage ?? "https://static.remove.bg/sample-gallery/graphics/bird-thumbnail.jpg")
                self.leftImageView.sd_setImage(with: imageURL)

                self.leftImageView.layer.cornerRadius = 20
                self.leftImageView.clipsToBounds = true

                dateLabel.textColor = .gray
                let publishedDateString = data.publishedAt ?? "1970-01-01T01:01:01Z"
                dateLabel.text = publishedDateString.dateFormater()
                dateLabel.font = UIFont.boldSystemFont(ofSize: 14)

                setUpUI()
                
            }
    }
    

    
    private func setUpUI() {
        backgroundColor = .white
        layer.cornerRadius = 20
        layer.shadowOpacity = 0.05
        layer.shadowRadius = 10
        
        contentView.addSubview(leftImageView)
        leftImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(cellTitle)
        cellTitle.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            leftImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            leftImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            leftImageView.heightAnchor.constraint(equalToConstant: 140),
            leftImageView.widthAnchor.constraint(equalToConstant: 140),
            
            cellTitle.leftAnchor.constraint(equalTo: leftImageView.rightAnchor, constant: 12),
            cellTitle.centerYAnchor.constraint(equalTo: leftImageView.centerYAnchor),
            cellTitle.rightAnchor.constraint(equalTo: dateLabel.rightAnchor),
            cellTitle.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.65),
            
            dateLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -7)
        ])
        
    }

}
