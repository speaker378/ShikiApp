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
    func shareURL()
}

final class NewsDetailPresenter: NewsDetailViewOutput {
    
    // MARK: - Properties
    
    weak var viewInput: (UIViewController & NewsDetailViewInput)?
    
    // MARK: - Functions
    
    func shareURL() {
        guard
            let URLString = viewInput?.news.URLString,
            let url = URL(string: URLString),
            let shareItems = [url] as? [Any]
        else { return }
        let activityViewController = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
        self.viewInput?.present(activityViewController, animated: true)
    }
}
