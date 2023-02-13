//
//  SearchViewController+Extensions.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 02.02.2023.
//

import UIKit

// MARK: - UITableViewDataSource

extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: SearchTableCell = tableView.cell(forRowAt: indexPath) else { return UITableViewCell() }
        guard models.indices.contains(indexPath.row) else { return cell }
        cell.configure(with: models[indexPath.row])
        return UITableViewCell()
    }
}

// MARK: - UITableViewDelegate

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        ControlConstants.Properties.cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let entity = models[indexPath.row]
        self.presenter.viewDidSelectNews(entity: entity)
    }
}

// MARK: SearchViewDelegate

extension SearchViewController: SearchViewDelegate {

    // MARK: - Functions

    func onContentTypeChanged(index: Int) {
        let content = SearchContentEnum
            .allCases
            .enumerated()
            .first(where: { $0.offset == index })
            .map { $0.element } ?? .anime
        presenter.setLayer(layer: content)
    }

    func onFilterButtonTap() {
        presenter.requestFilters()
    }
}

// MARK: - UITextFieldDelegate

extension SearchViewController: UITextFieldDelegate {

    // MARK: - Functions

    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
