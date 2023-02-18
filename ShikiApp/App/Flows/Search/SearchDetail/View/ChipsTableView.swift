//
//  ChipsTableView.swift
//  ShikiApp
//
//  Created by 👩🏻‍🎨 📱 december11 on 16.02.2023.
//

import UIKit

final class ChipsTableView: UITableView {

    // MARK: - Private properties
    
    private var values = [String]()
    private var chipValues = [[String]]()

    // MARK: - Consructions
    
    init(values: [String]) {
        self.values = values
        super.init(frame: .zero, style: .plain)
        self.chipValues = makeChipsValues()
        configure()
    }
    
    required init?(coder: NSCoder) { nil }

    // MARK: - Private functions
    
    private func configure() {
        delegate = self
        dataSource = self
        registerCell(ChipsTableViewCell.self)
        separatorStyle = .none
    }
    
    // TODO: - перенести в презентер
    private func makeChipsValues() -> [[String]] {
        let maxWidth = UIScreen.main.bounds.width - 32.0
        let chipsHorizontalInset: CGFloat = 8.0
        let spacing = 4.0
        var results = [[String]]()
        var lineWidth = 0.0
        var line = [String]()
        
        for index in 0 ..< values.count {
            let currentWord = NSAttributedString(string: values[index], attributes: [.font: AppFont.Style.subtitle])
            let chipsWidth = currentWord.size().width + chipsHorizontalInset + spacing
            if lineWidth + chipsWidth >= maxWidth || index == values.count-1 {
                results.append(line)
                line = [String]()
                lineWidth = 0.0
            }
            line.append(values[index])
            lineWidth += chipsWidth
        }
        return results
    }
}

// MARK: - UITableViewDataSource

extension ChipsTableView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chipValues.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        24.0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            chipValues.indices.contains(indexPath.row),
            let cell: ChipsTableViewCell = tableView.cell(forRowAt: indexPath)
        else { return UITableViewCell() }
        
        cell.configure(content: chipValues[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ChipsTableView: UITableViewDelegate {
    
}
