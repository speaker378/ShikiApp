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
    func updateData(completion: @escaping () -> Void)
    
    var targetType: UserRatesTargetType { get set }
    var status: UserRatesStatus? { get set }
    var error: String { get set }
}

final class UserRatesPresenter: UserRatesViewOutput {

    // MARK: - Properties

    weak var viewInput: (UIViewController & UserRatesViewInput)?
    
    private var ratesList: UserRatesResponseDTO = []
    private var contentResponse: [UserRatesContentProtocol] = []
    private var contentDetailList: [UserRatesContentProtocol] = []
    
    private var requestCount: Int = 0
    private let itemsLimit: Int = Constants.LimitsForRequest.itemsLimit
    private let limitRequestsPerSecond: Int = Constants.LimitsForRequest.limitRequestsPerSecond
    
    private let userRatesApiFactory = ApiFactory.makeUserRatesApi()
    private let usersApiFactory = ApiFactory.makeUsersApi()
    private let modelFactory = UserRatesModelFactory()
    
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
        if let userId = AuthManager.share.getUserInfo()?.id {
            self.userRatesApiFactory.getList(
                userId: userId,
                targetType: targetType,
                status: status
            ) { data, errorMessage in
                if let data {
                    self.ratesList = data
                    self.error = errorMessage ?? ""
                    print("ERROR: \(self.error)")
                    self.requestCount += 1
                    self.getDetails(
                        userId: userId,
                        targetType: targetType,
                        status: status,
                        pageCount: self.getPageCount(ratesList: self.ratesList)
                    )
                }
            }
        }
    }
    
    func updateData(completion: @escaping () -> Void) {
        getRatesList(targetType: targetType, status: status)
        completion()
    }

    // MARK: - Private functions

    private func getListAnimesFromMyList(
        userId: Int,
        status: UserRatesStatus?,
        page: Int,
        limit: Int
    ) {
        usersApiFactory.getAnimeRates(
            id: userId,
            page: page,
            limit: limit,
            status: status,
            isCensored: nil
        ) { [weak self] data, errorMessage in
            guard let self,
                  let data else { return }
            
            self.contentResponse = data.map { $0.anime }
            self.error = errorMessage ?? ""
            print("ERROR: \(self.error), PAGE: \(page)")
            self.contentDetailList.append(contentsOf: self.contentResponse)
            self.getContentDetailList(contentDetailList: self.contentDetailList, ratesList: self.ratesList)
        }
        self.requestCount += 1
    }
    
    private func getListMangasFromMyList(
        userId: Int,
        status: UserRatesStatus?,
        page: Int,
        limit: Int
    ) {
        usersApiFactory.getMangaRates(
            id: userId,
            page: page,
            limit: limit,
            status: status,
            isCensored: nil
        ) { [weak self] data, errorMessage in
            guard let self,
                  let data else { return }
            
            self.contentResponse = data.map { $0.manga }
            self.error = errorMessage ?? ""
            print("ERROR: \(self.error), PAGE: \(page)") 
            self.contentDetailList.append(contentsOf: self.contentResponse)
            self.getContentDetailList(contentDetailList: self.contentDetailList, ratesList: self.ratesList)
        }
        self.requestCount += 1
    }
    
    private func getDetails(userId: Int, targetType: UserRatesTargetType, status: UserRatesStatus?, pageCount: Int) {
        contentDetailList.removeAll()
        
        guard pageCount != 0 else {
            return getContentDetailList(contentDetailList: contentDetailList, ratesList: ratesList)
        }
        
        for page in 1...pageCount {
            let timeIntervalPerSecond = ((requestCount % limitRequestsPerSecond) == 0) ? 1 : 0
            
            sleep(UInt32(timeIntervalPerSecond))
            switch targetType {
            case .anime:
                self.getListAnimesFromMyList(userId: userId, status: status, page: page, limit: itemsLimit)
            case .manga:
                self.getListMangasFromMyList(userId: userId, status: status, page: page, limit: itemsLimit)
            }
        }
        self.requestCount = 0
    }
    
    private func getPageCount(ratesList: UserRatesResponseDTO) -> Int {
        let index: Int = ratesList.count % itemsLimit == 0 ? 0 : 1
        return Int((Double(ratesList.count/itemsLimit).rounded(.towardZero))) + index
    }
    
    private func getContentDetailList(contentDetailList: [UserRatesContentProtocol], ratesList: UserRatesResponseDTO) {
        if contentDetailList.count == ratesList.count {
            viewInput?.model = modelFactory.makeModels(from: contentDetailList, ratesList: ratesList)
        }
    }
}
