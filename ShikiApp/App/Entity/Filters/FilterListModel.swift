//
//  FilterListModel.swift
//  ShikiApp
//
//  Created by Константин Шмондрик on 14.02.2023.
//

import Foundation

// MARK: - FilterListModel

struct FilterListModel {
    var ratingList: String
    var typeList: String
    var statusList: String
    var genreList: String
    var seasonList: String
    var releaseYearStart: String
    var releaseYearEnd: String

    // MARK: - Functions

    func isEmpty() -> Bool {
        return ratingList.isEmpty &&
            typeList.isEmpty &&
            statusList.isEmpty &&
            genreList.isEmpty &&
            seasonList.isEmpty &&
            releaseYearStart.isEmpty &&
            releaseYearEnd.isEmpty
    }
}
