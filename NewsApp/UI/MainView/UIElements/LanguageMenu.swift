//
//  LanguageMenu.swift
//  NewsApp
//
//  Created by Adam Pilarski on 29/05/2023.
//

import UIKit

class LanguageMenu: UIView {
    //MARK: - Variables
    private let languages = ["ae", "ar", "at", "au", "be", "bg", "br", "ca", "ch", "cn", "co", "cu", "cz", "de", "eg", "fr", "gb", "gr", "hk", "hu", "id", "ie", "il", "in", "it", "jp", "kr", "lt", "lv", "ma", "mx", "my", "ng", "nl", "no", "nz", "ph", "pl", "pt", "ro", "rs", "ru", "sa", "se", "sg", "si", "sk", "th", "tr", "tw", "ua", "us", "ve", "za"]
    var viewModel: MainViewModel
    
    //MARK: - UIElements
    let tableView = UITableView()
    
    
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
        // Initialize and configure the table view
        tableView.frame = bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(tableView)
        
        // Configure other properties of the table view
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor(named: "DefaultColor")
        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
}

//MARK: - Table Functions
extension LanguageMenu: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let lang = languages[indexPath.row]
        cell.textLabel?.text = lang
        cell.textLabel?.textColor = .black
        let imageURL = URL(string: "https://flagsapi.com/\(lang.uppercased())/flat/32.png")
        cell.imageView?.sd_setImage(with: imageURL)
        cell.backgroundColor = UIColor(named: "DefaultColor")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedLanguage = languages[indexPath.row]
        removeFromSuperview()
        self.viewModel.selectedLanguage = selectedLanguage
        self.viewModel.fetchNews(category: self.viewModel.selectedCategory, language: selectedLanguage)
    }
}

