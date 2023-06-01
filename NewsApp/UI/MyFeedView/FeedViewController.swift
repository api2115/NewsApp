//
//  FeedViewController.swift
//  NewsApp
//
//  Created by Adam Pilarski on 30/05/2023.
//

import UIKit

class FeedViewController: UIViewController {
    //MARK: - Protocol
    weak var delegate: DismissViewDelegateProtocol?
    
    //MARK: -UIElements
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .clear
        tv.separatorStyle = .none
        tv.register(NewsCell.self, forCellReuseIdentifier: NewsCell.identifier)
        return tv
    }()
    
    lazy var headerView = FeedHeaderView()
    
    //MARK: - Initializer
    let viewModel: FeedViewModel
    init(_ viewModel: FeedViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.headerView.backToMainButton.addTarget(self, action: #selector(backButtonTap), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpModelOutput()
        viewModel.fetchFeed()
        setUpUI()
    }
    
    //MARK: - SetUpFunctions
    private func setUpUI() {
        self.view.backgroundColor = UIColor(named: "DefaultColor")
        addToView(headerView)
        addToView(tableView)
        
        NSLayoutConstraint.activate(makeFeedViewContsraints())
    }

}
