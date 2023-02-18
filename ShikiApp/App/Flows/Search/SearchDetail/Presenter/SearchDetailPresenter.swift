//
//  SeatchDetailPresenter.swift
//  ShikiApp
//
//  Created by 👩🏻‍🎨 📱 december11 on 14.02.2023.
//

import UIKit

protocol SearchDetailViewInput: AnyObject {
    
}

protocol SearchDetailViewOutput: AnyObject {
    
}

final class SearchDetailPresenter: SearchDetailViewOutput {

    // MARK: - Properties
    
    weak var viewInput: (UIViewController & SearchDetailViewInput)?
    
//    private var errorString: String? { didSet {
//        guard let errorString  else {
//            viewInput?.hideError()
//            return
//        }
//        viewInput?.showError(errorString: errorString)
//        }
//    }
    
//    private let animeProvider = AnimeDetailProvider()
//
//    private var entityList = [SearchContentProtocol]() {
//        didSet {
//            viewInput?.models = SearchModelFactory().makeModels(from: entityList)
//        }
//    }
//
//    private var providers: [SearchContentEnum: any ContentProviderProtocol] = [
//        .anime: AnimeProvider(),
//        .manga: MangaProvider(),
//        .ranobe: RanobeProvider()
//    ]

    // MARK: - Functions

//    func fetchData() {
//        animeProvider.fetchAnimeDetailData(id: <#T##Int#>, completion: { response, error in
//            <#code#>
//        })  {[weak self] data, error in
//            if let data {
//                self?.entityList = data
//                return
//            }
//            self?.entityList.removeAll()
//            self?.errorString = error
//        }
//    }
}
