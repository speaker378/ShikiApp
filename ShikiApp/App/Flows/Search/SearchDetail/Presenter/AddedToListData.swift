//
//  AddedToListData.swift
//  ShikiApp
//
//  Created by 👩🏻‍🎨 📱 december11 on 20.02.2023.
//

import Foundation

final class AddedToListData {

    // MARK: - Properties
    
    static let shared = AddedToListData()

    // MARK: - Private properties
    
    private(set) var addedModels = [SearchDetailModel]()

    // MARK: - Constructions
    
    private init() {}

    // MARK: - Functions
    
    func addToList(_ content: SearchDetailModel) {
        guard !addedModels.contains(content) else { return }
        addedModels.append(content)
    }
}
