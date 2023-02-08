//
//  NewsDetailContentPresenter.swift
//  ShikiApp
//
//  Created by 👩🏻‍🎨 📱 december11 on 07.02.2023.
//

import UIKit

protocol NewsDetailContentViewInput: AnyObject {
    
}

protocol NewsDetailContentViewOutput: AnyObject {
    func makeYoutubeID(link: String) -> String?
}

final class NewsDetailContentPresenter: NewsDetailContentViewOutput {

    // MARK: - Properties
    
    weak var viewInput: (UIViewController & NewsDetailContentViewInput)?

    func makeYoutubeID(link: String) -> String? {
        guard link.contains("youtube") else { return nil }
        
        let youtubeID = link
                        .replacingOccurrences(of: "https://img.youtube.com/vi/", with: "")
                        .replacingOccurrences(of: "/hqdefault.jpg", with: "")
        
        return youtubeID
    }
}
