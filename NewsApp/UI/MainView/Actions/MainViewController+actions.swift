//
//  MainViewController+actions.swift
//  NewsApp
//
//  Created by Adam Pilarski on 25/05/2023.
//

import UIKit

extension MainViewController: DataDelegateProtocol, DismissViewDelegateProtocol {
    
    //MARK: - Protocol
    func didDismiss() {
        self.topView.collectionView.reloadData()
    }
    
    func passData(data: News, tapCase: TapCase) {
        switch tapCase {
        case .detailedViewTap:
            let vc = DetailedViewController(data)
            vc.modalPresentationStyle = .fullScreen
            vc.delegate = self
            self.present(vc, animated: true, completion: nil)
        case .addToFeed:
            feedViewModel.input?.addNews(data)
        case .removeFromFeed:
            feedViewModel.deleteFeedNews(news: data)
        }
        
    }
    
    //MARK: - Button Functions
    
    func setUpTargets() {
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        headerView.languageButton.addTarget(self, action: #selector(showLanguageMenu), for: .touchUpInside)
        headerView.myFeedButton.addTarget(self, action: #selector(showMyFeed), for: .touchUpInside)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOutsideLangMenu(_:)))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func showLanguageMenu() {
        setUpLanguageMenu()
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
    
    @objc func showMyFeed() {
        let vc = FeedViewController(feedViewModel)
//        vc.modalPresentationStyle = .fullScreen
        vc.delegate = self
//        self.present(vc, animated: true, completion: nil)

        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func handleTapOutsideLangMenu(_ gestureRecognizer: UITapGestureRecognizer) {
        let tapLocation = gestureRecognizer.location(in: self.view)
        
        if !languageMenu.frame.contains(tapLocation) {
            languageMenu.removeFromSuperview()
        }
    }
    
    @objc func refreshData() {
        self.viewModel.fetchNews(category: self.viewModel.selectedCategory, language: self.viewModel.selectedLanguage)
        refreshControl.endRefreshing()
    }
    
    //MARK: - DATA
    func setUpModelOutput() {
        self.viewModel.output = .init(
            onNewsUpdated: { [weak self] in
                DispatchQueue.main.async {
//                    if ((self?.viewModel.news) != nil) {
//                        self?.topView.horizontalScrol.dataSource = Array(self?.viewModel.news.prefix(4) ?? [])
//                    }
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
    
    
    //MARK: - Miscellaneous
    func addToView(_ element: UIView) {
        self.view.addSubview(element)
        element.translatesAutoresizingMaskIntoConstraints = false
    }
    
    //MARK: - Constraints
    func makeMainViewConstraints() -> [NSLayoutConstraint] {
        [
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
        ]
    }
    
    
}

