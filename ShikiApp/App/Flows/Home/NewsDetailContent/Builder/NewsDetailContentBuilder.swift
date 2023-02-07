//
//  NewsDetailContentBuilder.swift
//  ShikiApp
//
//  Created by 👩🏻‍🎨 📱 december11 on 07.02.2023.
//

import UIKit

final class NewsDetailContentBuilder {
    
    static func build(imageURLString: String) -> (UIViewController & NewsDetailContentViewInput) {
        let presenter = NewsDetailContentPresenter()
        let viewController = NewsDetailContentViewController(presenter: presenter, imageURLString: imageURLString)
        
        presenter.viewInput = viewController
        return viewController
    }
}
