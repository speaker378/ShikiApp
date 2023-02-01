//
//  NewsfeedPresenter.swift
//  ShikiApp
//
//  Created by Сергей Черных on 23.01.2023.
//

import UIKit

protocol NewsfeedViewInput: AnyObject {
    
    var models: [NewsModel] { get set }
    func reloadData()
    func showErrorBackground()
}

protocol NewsfeedViewOutput: AnyObject {
    
    func viewDidSelectNews(news: NewsModel)
    func fetchData()
}

final class NewsfeedPresenter: NewsfeedViewOutput {

    // MARK: - Properties
    
    weak var viewInput: (UIViewController & NewsfeedViewInput)?

    // MARK: - Private properties
    
    private let factory = ApiFactory.makeTopicsApi()
    private var newsList: TopicsResponseDTO? {
        willSet { fetchData() }
    }

    // MARK: - Private functions
    
    private func getDataFromServer() {
        factory.listTopics(
            page: 1,
            limit: 20,
            forum: .news
        ) { [weak self] data, _ in
            guard let data else {
                self?.viewInput?.showErrorBackground()
                return
            }
            self?.newsList = data
        }
    }

    // MARK: - Functions
    
    func viewDidSelectNews(news: NewsModel) {
        let newsDetailViewController = NewsDetailBuilder.build(news: news)
        viewInput?.navigationController?.pushViewController(newsDetailViewController, animated: true)
    }
    
    func fetchData() {
        if let newsList {
            viewInput?.models = NewsModelFactory().makeModels(from: newsList)
            viewInput?.reloadData()
        } else {
            getDataFromServer()
        }
    }
}
