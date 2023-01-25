//
//  NewsDetailPresenter.swift
//  ShikiApp
//
//  Created by 👩🏻‍🎨 📱 december11 on 24.01.2023.
//

import UIKit

protocol NewsDetailViewInput: AnyObject {
    var news: NewsModel { get set }
}

protocol NewsDetailViewOutput: AnyObject {
    func navBarItemTapped()
}

final class NewsDetailPresenter: NewsDetailViewOutput {
    
    // MARK: - Properties
    
    weak var viewInput: (UIViewController & NewsDetailViewInput)?
    
    // MARK: - Functions
    
    func navBarItemTapped() {
        guard let URLString = viewInput?.news.URLString else { return }
        let url = URL(string: URLString)
        let shareItems = [url as Any]
        let activityViewController = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
        viewInput?.present(activityViewController, animated: true, completion: nil)
    }
    
}
