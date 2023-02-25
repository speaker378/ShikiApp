//
//  MenuItemsListTableViewCell.swift
//  ShikiApp
//
//  Created by Константин Шмондрик on 19.02.2023.
//

import UIKit

class MenuItemsListTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        textLabel?.textColor = selected ? AppColor.accent : AppColor.textMain
    }
}
