//
//  SearchDetailView+Extensions.swift
//  ShikiApp
//
//  Created by 👩🏻‍🎨 📱 december11 on 13.03.2023.
//

import UIKit

// MARK: - StepperViewDataSource

extension SearchDetailView: StepperViewDataSource {
    
    func stepperViewMaximumValue(_ stepperView: StepperView) -> Int? {
        var max: Int?
        switch content.type {
        case UserRatesTargetType.manga.rawValue:
            if let chapters = content.chapters, chapters > 0 {
                max = chapters
            }
        case UserRatesTargetType.anime.rawValue:
            if content.kind == Constants.kindsDictionary[AnimeContentKind.movie.rawValue] {
                max = 1
            } else if let episodes = content.episodes {
                max = episodes
            }
            if let aired = content.episodesAired, aired > 0 {
                max = aired
            }
        default: break
        }
        
        return max
    }
    
    func stepperViewCurrentValue(_ stepperView: StepperView) -> Int {
        guard let rateType = RatesTypeItemEnum(rawValue: content.userRate?.status ?? "") else { return 0 }
        if rateType == .rewatching, let rewatches = content.userRate?.rewatches {
            return rewatches
        }
        
        let episodes = content.userRate?.episodes ?? 0
        let chapters = content.userRate?.chapters ?? 0
        
        return content.type == UserRatesTargetType.anime.rawValue ? episodes : chapters
    }
    
    func stepperViewTitle(_ stepperView: StepperView) -> String {
        content.type == UserRatesTargetType.manga.rawValue ? Texts.DetailLabels.chapters : Texts.DetailLabels.episodes
    }
}

// MARK: - StepperViewDelegate

extension SearchDetailView: StepperViewDelegate {

    // MARK: - Functions
    
    func stepperViewDidFinishValueChanges(_ stepperView: StepperView, value: Int) {
        AddedToListData.shared.update(content)
        // тут будет сохранение в CoreData или в сеть после изменения значения степпера
    }
    
    func stepperViewValueWasChanged(_ stepperView: StepperView, value: Int, maxValue: Int?) {
        guard let listType = correctRateType(value: value, maxValue: maxValue) else { return }
        if listType == .rewatching {
            configureUserList(listType: .rewatching, rewatches: value)
            return
        }
        
        switch content.type {
        case UserRatesTargetType.anime.rawValue:
            configureUserList(listType: listType, episodes: value)
        case UserRatesTargetType.manga.rawValue:
            configureUserList(listType: listType, chapters: value)
        default: break
        }
    }

    // MARK: - Private functions
    
    private func correctRateType(value: Int, maxValue: Int?) -> RatesTypeItemEnum? {
        guard let rateType = RatesTypeItemEnum(rawValue: content.userRate?.status ?? "") else { return nil }
        
        if rateType != .planned && value == 0 {
            return .planned
        }
        
        switch rateType {
        case .planned:
            if let maxValue, value >= 1 && value == maxValue {
                return .completed
            } else if value >= 1 {
                return .watching
            }
        case .watching, .dropped, .onHold:
            if let maxValue, value > 0 && value == maxValue {
                return .completed
            }
        case .completed:
            if let maxValue, value < maxValue && value > 0 {
                return .watching
            }
        default:
            break
        }
        
        return rateType
    }
}
