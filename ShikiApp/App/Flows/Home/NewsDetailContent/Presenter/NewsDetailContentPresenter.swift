//
//  NewsDetailContentPresenter.swift
//  ShikiApp
//
//  Created by 👩🏻‍🎨 📱 december11 on 07.02.2023.
//

import UIKit

protocol NewsDetailContentViewInput: AnyObject { }

protocol NewsDetailContentViewOutput: AnyObject {
    func makeYoutubeID(link: String) -> String?
}

final class NewsDetailContentPresenter: NewsDetailContentViewOutput {

    // MARK: - Properties
    
    weak var viewInput: (UIViewController & NewsDetailContentViewInput)?

    func makeYoutubeID(link: String) -> String? {
        guard link.contains("youtube") else { return nil }
        var youtubeID = link.replacingOccurrences(of: "/hqdefault.jpg", with: "")
        if link.hasPrefix("http://") {
            youtubeID = youtubeID.replacingOccurrences(of: "http://img.youtube.com/vi/", with: "")
        } else {
            youtubeID = youtubeID.replacingOccurrences(of: "https://img.youtube.com/vi/", with: "")
        }
        return youtubeID
    }
}
