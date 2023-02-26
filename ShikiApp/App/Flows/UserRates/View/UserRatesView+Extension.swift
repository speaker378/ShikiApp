//
//  UserRatesView+Extension.swift
//  ShikiApp
//
//  Created by Константин Шмондрик on 19.02.2023.
//

import UIKit

extension UserRatesView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView == selectTableView ? dataSource.count : filteredModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == selectTableView {
            guard let cell: MenuItemsListTableViewCell = tableView.cell(forRowAt: indexPath) else {
                return UITableViewCell()
            }
            
            cell.textLabel?.text = dataSource[indexPath.row]
            return cell
        } else if tableView == ratesTableView {
            guard let cell: UserRatesTableViewCell = tableView.cell(forRowAt: indexPath) else {
                return UITableViewCell()
            }
            
            cell.configure(with: filteredModel[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView == selectTableView ? Constants.Insets.controlHeight : ControlConstants.Properties.cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if tableView == selectTableView {
            let data = dataSource[indexPath.row]
            selectedButton.configurate(text: data, isSelect: true)
            filterModelByTypesSelect(status: data)
            delegate?.statusValueChanged(status: data)
            self.removeTransparentView()
        } else if tableView == ratesTableView {
            let entity = filteredModel[indexPath.row]
            self.delegate?.viewDidSelectEntity(entity: entity)
        }
    }
    
    func addTransparentView(frames: CGRect) {
        let window = UIApplication.firstKeyWindowForConnectedScenes
        transparentView.frame = window?.frame ?? self.frame
        self.addSubview(transparentView)
        
        selectTableView.frame = CGRect(
            x: frames.origin.x,
            y: frames.origin.y + frames.height,
            width: frames.width,
            height: 0
        )
       
        self.addSubview(selectTableView)
        
        transparentView.backgroundColor = AppColor.backgroundMinor
        selectTableView.reloadData()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapGesture)
        transparentView.alpha = 0
        let height: CGFloat =
        CGFloat(CGFloat(self.dataSource.count) * Constants.Insets.controlHeight)
        UIView.animate(
            withDuration: 0.4,
            delay: 0.0,
            usingSpringWithDamping: 1.0,
            initialSpringVelocity: 1.0,
            options: .curveEaseInOut,
            animations: {
                self.transparentView.alpha = 0.5
                self.selectTableView.frame = CGRect(
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
        layoutIfNeeded()
        UIView.animate(
            withDuration: 0.4,
            delay: 0.0,
            usingSpringWithDamping: 1.0,
            initialSpringVelocity: 1.0,
            options: .curveEaseInOut,
            animations: {
                self.transparentView.alpha = 0
                self.selectTableView.frame = CGRect(
                    x: frames.origin.x,
                    y: frames.origin.y + frames.height,
                    width: frames.width,
                    height: 0
                )
                self.layoutIfNeeded()
                self.frame = CGRect(
                    x: .zero,
                    y: .zero,
                    width: frames.width,
                    height: self.bounds.height
                )
                
            }, completion: nil
        )
    }
}
