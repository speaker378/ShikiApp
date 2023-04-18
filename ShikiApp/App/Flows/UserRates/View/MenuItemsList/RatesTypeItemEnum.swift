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
    
    func getString(isAnime: Bool = true) -> String {
        switch self {
        case .all:
            return isAnime ? Texts.ListTypesSelectItems.all : Texts.ListMangaTypesSelectItems.all
        case .completed:
            return isAnime ? Texts.ListTypesSelectItems.completed : Texts.ListMangaTypesSelectItems.completed
        case .planned:
            return isAnime ? Texts.ListTypesSelectItems.planned : Texts.ListMangaTypesSelectItems.planned
        case .watching:
            return isAnime ? Texts.ListTypesSelectItems.watching : Texts.ListMangaTypesSelectItems.watching
        case .onHold:
            return isAnime ? Texts.ListTypesSelectItems.onHold : Texts.ListMangaTypesSelectItems.onHold
        case .dropped:
            return isAnime ? Texts.ListTypesSelectItems.dropped : Texts.ListMangaTypesSelectItems.dropped
        case .rewatching:
            return isAnime ? Texts.ListTypesSelectItems.rewatching : Texts.ListMangaTypesSelectItems.rewatching
        }
    }
    
//    init?(status: String) {
//        switch status {
//        case Texts.ListTypesSelectItems.all: self = .all
//        case Texts.ListTypesSelectItems.completed: self = .completed
//        case Texts.ListTypesSelectItems.planned: self = .planned
//        case Texts.ListTypesSelectItems.watching: self = .watching
//        case Texts.ListTypesSelectItems.onHold: self = .onHold
//        case Texts.ListTypesSelectItems.dropped: self = .dropped
//        case Texts.ListTypesSelectItems.rewatching: self = .rewatching
//        default: return nil
//        }
//    }
    
    init?(status: String) {
        switch status {
        case Texts.ListTypesSelectItems.all: self = .all
        case
            Texts.ListTypesSelectItems.completed,
            Texts.ListMangaTypesSelectItems.completed: self = .completed
        case
            Texts.ListTypesSelectItems.planned,
            Texts.ListMangaTypesSelectItems.planned: self = .planned
        case
            Texts.ListTypesSelectItems.watching,
            Texts.ListMangaTypesSelectItems.watching: self = .watching
        case
            Texts.ListTypesSelectItems.onHold,
            Texts.ListMangaTypesSelectItems.onHold: self = .onHold
        case
            Texts.ListTypesSelectItems.dropped,
            Texts.ListMangaTypesSelectItems.dropped: self = .dropped
        case
            Texts.ListTypesSelectItems.rewatching,
            Texts.ListMangaTypesSelectItems.rewatching: self = .rewatching
        default:
            return nil
        }
    }
}
