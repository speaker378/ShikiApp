//
//  RatesTypeItemEnum.swift
//  ShikiApp
//
//  Created by Константин Шмондрик on 19.02.2023.
//

import UIKit

enum RatesTypeItemEnum: String, CaseIterable {
   
    case all
    case completed
    case planned
    case watching
    case onHold
    case dropped
    case rewatching
    
    func getString() -> String {
        switch self {
        case .all:
            return Texts.ListTypesSelectItems.all
        case .completed:
            return Texts.ListTypesSelectItems.completed
        case.planned:
            return Texts.ListTypesSelectItems.planned
        case .watching:
            return Texts.ListTypesSelectItems.watching
        case .onHold:
            return Texts.ListTypesSelectItems.onHold
        case .dropped:
            return Texts.ListTypesSelectItems.dropped
        case .rewatching:
            return Texts.ListTypesSelectItems.rewatching
        }
    }
}
