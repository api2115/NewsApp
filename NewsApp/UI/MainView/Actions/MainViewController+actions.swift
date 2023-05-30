//
//  MainViewController+actions.swift
//  NewsApp
//
//  Created by Adam Pilarski on 25/05/2023.
//

import UIKit

extension MainViewController: DataDelegateProtocol {
    //MARK: - Protocol
    func passData(data: News) {
        let vc = DetailedViewController(data)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    //MARK: - Button Functions
    @objc func showLanguageMenu() {
        setUpLanguageMenu()
    }
    
    @objc func handleTapOutsideLangMenu(_ gestureRecognizer: UITapGestureRecognizer) {
        let tapLocation = gestureRecognizer.location(in: self.view)
        
        if !languageMenu.frame.contains(tapLocation) {
            languageMenu.removeFromSuperview()
        }
    }
    
    //MARK: - Miscellaneous
    func addToView(_ element: UIView) {
        self.view.addSubview(element)
        element.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func getImageFromURL(url: URL, completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
}

