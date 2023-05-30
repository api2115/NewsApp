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
    
    //MARK: - UI Components
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .clear
        tv.separatorStyle = .none
        tv.register(NewsCell.self, forCellReuseIdentifier: NewsCell.identifier)
        return tv
    }()

    lazy var headerView = MainHeaderView()
    lazy var categoryScroll = CategoryScroll(viewModel)
    lazy var languageMenu = LanguageMenu(viewModel)
    lazy var topView = TopView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 250))
    
    //MARK: - Lifecycle
    init(_ viewModel: MainViewModel = MainViewModel()){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        topView.horizontalScrol.delegate = self
        
        self.setUpUI()
        
        self.tableView.tableHeaderView = topView
        
        self.setUpModelOutput()
        
        headerView.languageButton.addTarget(self, action: #selector(showLanguageMenu), for: .touchUpInside)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOutsideLangMenu(_:)))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)

    }
    
    //MARK: - SetUp Functions
    private func setUpUI() {
        self.view.backgroundColor = UIColor(named: "DefaultColor")

        addToView(headerView)
        addToView(tableView)
        addToView(categoryScroll)

        NSLayoutConstraint.activate([
            headerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            headerView.topAnchor.constraint(equalTo: self.view.topAnchor),
            headerView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.15),
            headerView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            
            categoryScroll.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 10),
            categoryScroll.heightAnchor.constraint(equalToConstant: 30),
            categoryScroll.widthAnchor.constraint(equalTo: self.view.widthAnchor),


            tableView.topAnchor.constraint(equalTo: categoryScroll.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
        ])
    }
    
    func setUpLanguageMenu() {
        addToView(languageMenu)

        NSLayoutConstraint.activate([
            languageMenu.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            languageMenu.topAnchor.constraint(equalTo: self.view.topAnchor),
            languageMenu.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.4),
            languageMenu.heightAnchor.constraint(equalTo: self.view.heightAnchor),
        ])
    }

    func setUpModelOutput() {
        self.viewModel.output = .init(
            onNewsUpdated: { [weak self] in
                DispatchQueue.main.async {
                    if ((self?.viewModel.news) != nil) {
                        self?.topView.horizontalScrol.dataSource = Array(self?.viewModel.news.prefix(4) ?? [])
                    }
                    self?.tableView.reloadData()
    //                let indexPath = IndexPath(row: 0, section: 0)
    //                self?.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                }
            },
            onErrorMessage: {  [weak self] error in
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                    
                    switch error {
                    case .serverError(let serverError):
                        alert.title = "Server Error \(serverError.code)"
                        alert.message = serverError.message
                    case .unknown(let string):
                        alert.title = "Error Fetching News"
                        alert.message = string
                    case .decodingError(let string):
                        alert.title = "Error Parsing Data"
                        alert.message = string
                    }
                    
                    self?.present(alert, animated: true, completion: nil)
                }
            }
        )
    }

}

