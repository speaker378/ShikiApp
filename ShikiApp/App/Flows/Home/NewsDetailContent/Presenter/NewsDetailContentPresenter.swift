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
    func shareURL()
}

final class NewsDetailContentPresenter: NewsDetailContentViewOutput {

    // MARK: - Properties
    
    weak var viewInput: (UIViewController & NewsDetailContentViewInput)?

    // MARK: - Functions
    
    func shareURL() {
        //
    }
}
