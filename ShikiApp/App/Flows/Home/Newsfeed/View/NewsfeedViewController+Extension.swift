//
//  NewsfeedViewController+Extension.swift
//  ShikiApp
//
//  Created by Сергей Черных on 24.01.2023.
//

import UIKit

// MARK: - UITableViewDataSource

extension NewsfeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: NewsfeedTableViewCell = tableView.cell(forRowAt: indexPath) else { return UITableViewCell() }
        guard models.indices.contains(indexPath.row) else { return cell }
        cell.configure(with: models[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate

extension NewsfeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        112
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let news = models[indexPath.row]
        self.presenter.viewDidSelectNews(news: news)
    }
}

// MARK: - UITableViewDataSourcePrefetching

extension NewsfeedViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard let maxRow = indexPaths.map({ $0.row }).max() else { return }
        if maxRow > models.count - 3 {
            presenter.endOfTableReached()
        }
    }
}

// MARK: - UIGestureRecognizerDelegate

extension NewsfeedViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive event: UIEvent) -> Bool {
        true
    }
}
