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
        case .planned:
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
    
    init?(status: String) {
        switch status {
        case Texts.ListTypesSelectItems.all: self = .all
        case Texts.ListTypesSelectItems.completed: self = .completed
        case Texts.ListTypesSelectItems.planned: self = .planned
        case Texts.ListTypesSelectItems.watching: self = .watching
        case Texts.ListTypesSelectItems.onHold: self = .onHold
        case Texts.ListTypesSelectItems.dropped: self = .dropped
        case Texts.ListTypesSelectItems.rewatching: self = .rewatching
        default: return nil
        }
    }
}
