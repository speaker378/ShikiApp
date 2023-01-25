//
//  NewsDetailBuilder.swift
//  ShikiApp
//
//  Created by 👩🏻‍🎨 📱 december11 on 24.01.2023.
//

import UIKit

class NewsDetailBuilder {
    
    static func build(news: NewsModel) -> (UIViewController & NewsDetailViewInput) {
        let presenter = NewsDetailPresenter()
        let viewController = NewsDetailViewController(presenter: presenter, news: news)
        
        presenter.viewInput = viewController
        return viewController
    }
    
}
