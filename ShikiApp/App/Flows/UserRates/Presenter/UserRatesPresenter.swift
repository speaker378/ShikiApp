//
//  UserRatesPresenter.swift
//  ShikiApp
//
//  Created by Константин Шмондрик on 19.02.2023.
//

import UIKit

protocol UserRatesViewInput: AnyObject {
    var model: [UserRatesModel] { get set }
}

protocol UserRatesViewOutput: AnyObject {
    func viewDidSelectEntity(entity: UserRatesModel)
    func changeSegmentedValueChanged()
    func statusValueChanged()
    func getRatesList(targetType: UserRatesTargetType, status: UserRatesStatus?)
    
    var targetType: UserRatesTargetType { get set }
    var status: UserRatesStatus? { get set }
    var error: String { get set }
}

final class UserRatesPresenter: UserRatesViewOutput {

    // MARK: - Properties

    weak var viewInput: (UIViewController & UserRatesViewInput)?
   
    private var ratesList: UserRatesResponseDTO = []
    private var animesResponse: AnimesResponseDTO = []
    private var mangaResponse: MangaResponseDTO = []
    private var animesDetailList: AnimesResponseDTO = []
    private var mangaDetailList: MangaResponseDTO = []
    
    private let itemsLimit: Int = 50
    
    private let makeUserRatesApiFactory = ApiFactory.makeUserRatesApi()
    private let makeUsersApiFactory = ApiFactory.makeUsersApi()
    private let makeAnimesApiFactory = ApiFactory.makeAnimesApi()
    private let makeMangasApiFactory = ApiFactory.makeMangasApi()

    var targetType: UserRatesTargetType = .anime
    var status: UserRatesStatus?
    var error: String = ""

    // MARK: - Functions

    func viewDidSelectEntity(entity: UserRatesModel) {
        print("Entity details screen build will be done here\n \(entity)")
    }
    
    func changeSegmentedValueChanged() {
        getRatesList(targetType: targetType, status: status)
    }
    
    func statusValueChanged() {
        getRatesList(targetType: targetType, status: status)
    }

    func getRatesList(targetType: UserRatesTargetType, status: UserRatesStatus?) {
        makeUsersApiFactory.whoAmI { [weak self] user, _ in
            guard let self else { return }
            
            if let userId = user?.id {
                self.makeUserRatesApiFactory.getList(
                    userId: userId,
                    targetType: targetType,
                    status: status
                ) { data, errorMessage in
                    if let data {
                        self.ratesList = data
                        self.error = errorMessage ?? ""
                        print("ERROR: \(self.error)")
                        print("ratesList\(self.ratesList)")
                        
                        self.getDetails(
                            targetType: targetType,
                            status: status,
                            pageCount: self.getPageCount(ratesList: self.ratesList)
                        )
                    }
                }
            }
        }
    }

    // MARK: - Private functions

    private func getListAnimesFromMyList(
        status: [UserRatesStatus],
        page: Int,
        limit: Int
    ) {
        makeAnimesApiFactory.getAnimes(
            page: page,
            limit: limit,
            myList: status,
            order: .byPopularity
        ) { [weak self] data, errorMessage in
            guard let self,
                  let data else { return }
            
            self.animesResponse = data
            self.error = errorMessage ?? ""
            print("ERROR: \(self.error), PAGE: \(page)")
            print("animesResponse\(self.animesResponse)")
            self.animesDetailList.append(contentsOf: self.animesResponse)
            print("animesDetailList\(self.animesDetailList)")
        }
    }
    
    private func getListMangasFromMyList(
        status: [UserRatesStatus],
        page: Int,
        limit: Int
    ) {
        makeMangasApiFactory.getMangas(
            page: page,
            limit: limit,
            myList: status,
            order: .byPopularity
        ) { [weak self] data, errorMessage in
            guard let self,
                  let data else { return }
            
            self.mangaResponse = data
            self.error = errorMessage ?? ""
            print("ERROR: \(self.error), PAGE: \(page)")
            print("mangaResponse\(self.mangaResponse)")
            self.mangaDetailList.append(contentsOf: self.mangaResponse)
            print("mangaDetailList\(self.mangaDetailList)")
        }
    }
    
    private func getDetails(targetType: UserRatesTargetType, status: UserRatesStatus?, pageCount: Int) {
        var statusForDetail: [UserRatesStatus] = []
        animesDetailList.removeAll()
        mangaDetailList.removeAll()
       
        guard pageCount != 0 else { return }
        
        if status == nil {
            statusForDetail = [.watching, .reWatching, .planned, .onHold, .dropped, .completed]
        } else {
            statusForDetail = [status ?? .watching]
        }

 
            (1...pageCount).forEach {
                sleep(1)
                switch targetType {
                case .anime:
                    self.getListAnimesFromMyList(status: statusForDetail, page: $0, limit: self.itemsLimit)
                case .manga:
                    self.getListMangasFromMyList(status: statusForDetail, page: $0, limit: self.itemsLimit)
                }
            }
    }
    
    private func getPageCount(ratesList: UserRatesResponseDTO) -> Int {
        let index: Int = ratesList.count % itemsLimit == 0 ? 0 : 1
        return Int((Double(ratesList.count/itemsLimit).rounded(.towardZero))) + index
    }
}
