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
    
    func add(_ content: SearchDetailModel) {
        guard !addedModels.contains(content) else { return }
        addedModels.append(content)
    }
    
    func update(_ content: SearchDetailModel) {
        guard let index = addedModels.firstIndex(of: content) else {
//            add(content)
            return
        }
        addedModels[index] = content
    }
    
    func remove(_ content: SearchDetailModel) {
        guard let index = addedModels.firstIndex(of: content) else { return }
        addedModels.remove(at: index)
    }
}
