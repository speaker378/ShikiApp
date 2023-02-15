//
//  FiltersView+Extantion.swift
//  ShikiApp
//
//  Created by Константин Шмондрик on 12.02.2023.
//

import UIKit

extension FiltersView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell: MenuItemsTableViewCell = tableView.cell(forRowAt: indexPath) else { return UITableViewCell() }
        
        cell.textLabel?.text = dataSource[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.Insets.controlHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedButton.configurate(text: dataSource[indexPath.row], isSelect: true)
        self.removeTransparentView()
    }
    
    func addTransparentView(frames: CGRect) {
        let window = UIApplication.firstKeyWindowForConnectedScenes
        transparentView.frame = window?.frame ?? self.frame
        self.addSubview(transparentView)
        
        tableView.frame = CGRect(
            x: frames.origin.x,
            y: frames.origin.y + frames.height,
            width: frames.width,
            height: 0
        )
        self.addSubview(tableView)
        
        transparentView.backgroundColor = AppColor.backgroundMinor
        tableView.reloadData()
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapgesture)
        transparentView.alpha = 0
        let height: CGFloat = dataSource.count < 5 ?
        CGFloat(CGFloat(self.dataSource.count) * Constants.Insets.controlHeight) :
        CGFloat(220)
        
        UIView.animate(
            withDuration: 0.4,
            delay: 0.0,
            usingSpringWithDamping: 1.0,
            initialSpringVelocity: 1.0,
            options: .curveEaseInOut,
            animations: {
                self.transparentView.alpha = 0.5
                self.tableView.frame = CGRect(
                    x: frames.origin.x,
                    y: frames.origin.y + frames.height + 5,
                    width: frames.width,
                    height: height
                )
            }, completion: nil
        )
    }
    
    @objc func removeTransparentView() {
        let frames = selectedButton.frame
        UIView.animate(
            withDuration: 0.4,
            delay: 0.0,
            usingSpringWithDamping: 1.0,
            initialSpringVelocity: 1.0,
            options: .curveEaseInOut,
            animations: {
                self.transparentView.alpha = 0
                self.tableView.frame = CGRect(
                    x: frames.origin.x,
                    y: frames.origin.y + frames.height,
                    width: frames.width,
                    height: 0
                )
            }, completion: nil
        )
    }
}
