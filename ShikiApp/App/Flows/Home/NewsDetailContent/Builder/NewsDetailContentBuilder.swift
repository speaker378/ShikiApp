//
//  NewsDetailContentBuilder.swift
//  ShikiApp
//
//  Created by 👩🏻‍🎨 📱 december11 on 07.02.2023.
//

import UIKit

final class NewsDetailContentBuilder {
    
    static func build(URLString: String) -> (UIViewController & NewsDetailContentViewInput) {
        let presenter = NewsDetailContentPresenter()
        let viewController = NewsDetailContentViewController(presenter: presenter, URLString: URLString)
        
        presenter.viewInput = viewController
        return viewController
    }
}
