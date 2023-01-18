//
//  UITableView+RegisterCell.swift
//  ShikiApp
//
//  Created by Константин Шмондрик on 18.01.2023.
//
// Класс для регистрации ячейки в таблице
// Пример использования:
//  tableView.registerClass(MyCTableViewCell.self)
//  tableView.registerHeader(MyHeaderViewCell.self)
//  tableView.registerFooter(MyFooterViewCell.self)
//
//   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//   guard let cell: MyCell = tableView.cell(forRowAt: indexPath) else { return UITableViewCell() }
//
//     [code]

//   return cell
//  }

import UIKit

extension UITableView {

    func registerClass<T: UITableViewCell>(_ cellClass: T.Type) {
        register(cellClass.self, forCellReuseIdentifier: cellClass.cellIdentifier)
    }

    func cell<T: ReusableCellIdentifiable>(forRowAt indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withIdentifier: T.cellIdentifier, for: indexPath) as? T
    }

    func cell<T: ReusableCellIdentifiable>(forClass cellClass: T.Type) -> T? {
        return dequeueReusableCell(withIdentifier: T.cellIdentifier) as? T
    }

    func registerHeaderFooter<T: UITableViewHeaderFooterView>(_ forHeaderFooter: T.Type) {
        return register(forHeaderFooter.self, forHeaderFooterViewReuseIdentifier: forHeaderFooter.description())
    }

    func dequeHeaderFooter<T: UITableViewHeaderFooterView>() -> T? {
        return dequeueReusableHeaderFooterView(withIdentifier: T.description()) as? T
    }
}

extension UITableViewCell: ReusableCellIdentifiable { }

extension ReusableCellIdentifiable where Self: UITableViewCell {

    static var cellIdentifier: String {
        return String(describing: self)
    }
}
