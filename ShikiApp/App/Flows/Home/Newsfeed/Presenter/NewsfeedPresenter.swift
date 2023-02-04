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
    func insertRows(indexPath: [IndexPath])
    func showErrorBackground()
}

protocol NewsfeedViewOutput: AnyObject {
    
    func viewDidSelectNews(news: NewsModel)
    func fetchData()
    func endOfTableReached()
}

final class NewsfeedPresenter: NewsfeedViewOutput {

    // MARK: - Properties
    
    weak var viewInput: (UIViewController & NewsfeedViewInput)?

    // MARK: - Private properties
    
    private let apiFactory = ApiFactory.makeTopicsApi()
    private let modelFactory = NewsModelFactory()
    private var newsList: TopicsResponseDTO = []
    private var dataPortion: TopicsResponseDTO = []
    private var lastPageRequested = 0
    private var isLoading = false

    // MARK: - Private functions
    
    private func fetchDataFromServer(completion: @escaping () -> Void) {
        isLoading = true
        apiFactory.listTopics(
            page: lastPageRequested + 1,
            limit: 20,
            forum: .news
        ) { [weak self] data, _ in
            guard var data else {
                self?.viewInput?.showErrorBackground()
                return
            }
            if self?.lastPageRequested != 0 { data.removeFirst() }
            self?.dataPortion = data
            self?.lastPageRequested += 1
            self?.isLoading = false
            completion()
        }
    }

    // MARK: - Functions
    
    func viewDidSelectNews(news: NewsModel) {
        let newsDetailViewController = NewsDetailBuilder.build(news: news)
        viewInput?.navigationController?.pushViewController(newsDetailViewController, animated: true)
    }
    
    func fetchData() {
        fetchDataFromServer { [weak self] in
            guard let self else { return }
            self.newsList = self.dataPortion
            self.viewInput?.models = self.modelFactory.makeModels(from: self.newsList)
            self.viewInput?.reloadData()
        }
    }
    
    func endOfTableReached() {
        guard !isLoading else { return }
        fetchDataFromServer { [weak self] in
            guard let self else { return }
            let indexPaths = (self.newsList.count ..< self.newsList.count + self.dataPortion.count)
                .map { IndexPath(row: $0, section: 0) }
            self.newsList.append(contentsOf: self.dataPortion)
            self.viewInput?.models.append(contentsOf: self.modelFactory.makeModels(from: self.dataPortion))
            self.viewInput?.insertRows(indexPath: indexPaths)
            self.viewInput?.reloadData()
        }
    }
}
