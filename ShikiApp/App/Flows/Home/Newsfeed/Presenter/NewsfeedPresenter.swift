//
//  NewsfeedPresenter.swift
//  ShikiApp
//
//  Created by Сергей Черных on 23.01.2023.
//

import UIKit

protocol NewsfeedViewInput: AnyObject {
    var viewModels: [NewsViewModel] { get set }
}

protocol NewsfeedViewOutput: AnyObject {
    func viewDidSelectNews(news: NewsViewModel)
    func fetchData()
}

final class NewsfeedPresenter: NewsfeedViewOutput {
    // MARK: - Properties
    weak var viewInput: (UIViewController & NewsfeedViewInput)?
    
    // MARK: - Private properties
    private var newsList: [NewsModel] {
        return NEWSCELLMODELLIST
    }
    
    // MARK: - Functions
    func viewDidSelectNews(news: NewsViewModel) {
        let newsDetailViewController = NewsDetailViewController(news: news)
        viewInput?.navigationController?.pushViewController(newsDetailViewController, animated: true)
    }
    
    func fetchData() {
        viewInput?.viewModels = NewsViewModelFactory().constructViewModels(from: newsList)
    }
}
