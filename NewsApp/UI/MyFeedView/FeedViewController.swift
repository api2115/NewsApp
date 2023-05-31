//
//  FeedViewController.swift
//  NewsApp
//
//  Created by Adam Pilarski on 30/05/2023.
//

import UIKit

class FeedViewController: UIViewController {
    
    weak var delegate: DismissViewDelegateProtocol?
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .clear
        tv.separatorStyle = .none
        tv.register(NewsCell.self, forCellReuseIdentifier: NewsCell.identifier)
        return tv
    }()
    
    lazy var headerView = FeedHeaderView()
    
    let viewModel: FeedViewModel
    init(_ viewModel: FeedViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpModelOutput()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.headerView.backToMainButton.addTarget(self, action: #selector(backButtonTap), for: .touchUpInside)
        viewModel.fetchFeed()
        setUpUI()
    }
    
    private func setUpUI() {
        self.view.backgroundColor = UIColor(named: "DefaultColor")
        addToView(headerView)
        addToView(tableView)
        
        NSLayoutConstraint.activate([
            headerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            headerView.topAnchor.constraint(equalTo: self.view.topAnchor),
            headerView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.15),
            headerView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
        ])
    }
    

    private func setUpModelOutput() {
        self.viewModel.output = .init(
            onNewsUpdated: { [weak self] in
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        )
    }

}
