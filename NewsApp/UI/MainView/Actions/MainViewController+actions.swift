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
        self.topView.horizontalScrol.dataSource = Array(self.viewModel.news.prefix(4))
    }
    
    func passData(data: News, id: Int) {
        if id == 1 {
            let vc = DetailedViewController(data)
            vc.modalPresentationStyle = .fullScreen
            vc.delegate = self
            self.present(vc, animated: true, completion: nil)
        } else if id == 2 {
            feedViewModel.input?.addNews(data)
        } else if id == 3 {
            feedViewModel.deleteFeedNews(news: data)
        }
    }
    
    //MARK: - Button Functions
    @objc func showLanguageMenu() {
        setUpLanguageMenu()
    }
    
    @objc func showMyFeed() {
        let vc = FeedViewController(feedViewModel)
        vc.modalPresentationStyle = .fullScreen
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
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
    
    //MARK: - Miscellaneous
    func addToView(_ element: UIView) {
        self.view.addSubview(element)
        element.translatesAutoresizingMaskIntoConstraints = false
    }
    
}

