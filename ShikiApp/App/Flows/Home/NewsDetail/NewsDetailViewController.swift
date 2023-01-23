//
//  NewsDetailViewController.swift
//  ShikiApp
//
//  Created by Сергей Черных on 23.01.2023.
//

import UIKit

class NewsDetailViewController: UIViewController {
    let news: NewsViewModel
    
    init(news: NewsViewModel) {
        self.news = news
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }

}
