//
//  ListTableView.swift
//  ShikiApp
//
//  Created by 👩🏻‍🎨 📱 december11 on 02.03.2023.
//

import UIKit

final class ListTableView: UITableView {

    // MARK: - Properties
    
    var valuesCount: Int {
        return values.count
    }
    
    var didSelectRowHandler: ((String) -> Void)?

    // MARK: - Private properties
    
    private let cellHeight = Constants.Insets.controlHeight
    private var values = [String]()

    // MARK: - Construction
    
    init(values: [String]) {
        self.values = values
        super.init(frame: .zero, style: .plain)
        configure()
    }
    
    required init?(coder: NSCoder) { nil }

    // MARK: - Private functions
    
    private func configure() {
        dataSource = self
        delegate = self
        registerCell(ListTableViewCell.self)
        
        layer.cornerRadius = Constants.CornerRadius.medium
        backgroundColor = AppColor.backgroundMain
        separatorStyle = .none
    }
}

// MARK: - UITableViewDataSource

extension ListTableView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        values.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            values.indices.contains(indexPath.row),
            let cell: ListTableViewCell = tableView.cell(forRowAt: indexPath)
        else { return UITableViewCell() }
//        cell.selectionStyle = .none
        cell.configure(content: values[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ListTableView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        didSelectRowHandler?(values[indexPath.row])
    }
}
