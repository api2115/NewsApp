//
//  ViewController.swift
//  NewsApp
//
//  Created by Adam Pilarski on 25/05/2023.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Variables
    let viewModel: MainViewModel
    let feedViewModel = FeedViewModel()
    
    //MARK: - UI Components
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .clear
        tv.separatorStyle = .none
        tv.register(NewsCell.self, forCellReuseIdentifier: NewsCell.identifier)
        return tv
    }()
    
    let refreshControl = UIRefreshControl()

    lazy var headerView = MainHeaderView()
    lazy var categoryScroll = CategoryScroll(viewModel)
    lazy var languageMenu = LanguageMenu(viewModel)
    lazy var topView = TopView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 250))
    
    //MARK: - Lifecycle
    init(_ viewModel: MainViewModel = MainViewModel()){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        topView.horizontalScrol.delegate = self
        self.tableView.tableHeaderView = topView
        self.tableView.addSubview(refreshControl)
        refreshControl.tintColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpUI()
        
        self.setUpModelOutput()

        self.setUpTargets()

    }
    
    //MARK: - SetUp Functions
    private func setUpUI() {
        self.view.backgroundColor = UIColor(named: "DefaultColor")

        addToView(headerView)
        addToView(tableView)
        addToView(categoryScroll)

        NSLayoutConstraint.activate(makeMainViewConstraints())
    }
    


}

