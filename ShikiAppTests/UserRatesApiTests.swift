//
//  UserRatesApiTests.swift
//  ShikiAppTests
//
//  Created by Алексей Шинкарев on 24.02.2023.
//

import Foundation
@testable import ShikiApp
import XCTest

final class UserRatesApiTests: XCTestCase {
    
    let delayRequests = 1.0
    private let api2Test = "UserRatesRequestFactory"

    override func setUpWithError() throws {
        try? super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try? super.tearDownWithError()
    }

    func testGetEntityList() throws {
        
        let factory = ApiFactory.makeUserRatesApi()
        let request = "getList"
        var response: UserRatesResponseDTO?
        var error: String?
        let expectation = self.expectation(description: "\(api2Test).\(request) expectation timeout")

        ApiFactory.makeUsersApi().whoAmI { user, _ in
            if let userId = user?.id {
                Timer.scheduledTimer(withTimeInterval: self.delayRequests, repeats: false) { _ in
                    factory.getList(userId: userId) { data, errorString in
                        response = data
                        error = errorString
                        expectation.fulfill()
                    }
                }
            }
        }
        waitForExpectations(timeout: 15)
        XCTAssertNil(error, "Unexpected \(api2Test).\(request) error \(error ?? "")")
        XCTAssertNotNil(response, "Unexpected \(api2Test).\(request) nil result")
    }

    func testGetEntity() throws {
        
        let factory = ApiFactory.makeUserRatesApi()
        let request = "getById"
        var response: UserRatesDTO?
        var error: String?
        let expectation = self.expectation(description: "\(api2Test).\(request) expectation timeout")

        ApiFactory.makeUsersApi().whoAmI { user, _ in
            if let userId = user?.id {
                Timer.scheduledTimer(withTimeInterval: self.delayRequests, repeats: false) { _ in
                    factory.getList(userId: userId) { rates, _ in
                        if let rateId = rates?.first?.id {
                            Timer.scheduledTimer(withTimeInterval: self.delayRequests, repeats: false) { _ in
                                factory.getById(id: rateId) { data, errorString in
                                    response = data
                                    error = errorString
                                    expectation.fulfill()
                                }
                            }
                        }
                    }
                }
            }
        }
        waitForExpectations(timeout: 15)
        XCTAssertNil(error, "Unexpected \(api2Test).\(request) error \(error ?? "")")
        XCTAssertNotNil(response, "Unexpected \(api2Test).\(request) nil result")
    }

    func testPostEntity() throws {
        
        if !AuthManager.share.isAuth() { return }
        let factory = ApiFactory.makeUserRatesApi()
        let request = "postEntity"
        var response: UserRatesDTO?
        var error: String?
        let expectation = self.expectation(description: "\(api2Test).\(request) expectation timeout")

        ApiFactory.makeUsersApi().whoAmI { user, _ in
            if let user {
                Timer.scheduledTimer(withTimeInterval: self.delayRequests, repeats: false) { _ in
                    ApiFactory.makeAnimesApi().getAnimes(page: 1, limit: 5, search: "Hero") { animes, _ in
                        if let anime = animes?.first {
                            let state = UserRatesState(
                                status: .watching,
                                score: 0,
                                chapters: 0,
                                episodes: 1,
                                volumes: 1,
                                rewatches: 0,
                                text: "qwerty"
                            )
                            Timer.scheduledTimer(withTimeInterval: self.delayRequests, repeats: false) { _ in
                                factory.postEntity(
                                    userId: user.id,
                                    targetId: anime.id,
                                    targetType: .anime,
                                    state: state
                                ) { entity, errorString in
                                    response = entity
                                    error = errorString
                                    expectation.fulfill()
                                }
                            }
                        }
                    }
                }
            }
        }
        waitForExpectations(timeout: 45)
        XCTAssertNil(error, "Unexpected \(api2Test).\(request) error \(error ?? "")")
        XCTAssertNotNil(response, "Unexpected \(api2Test).\(request) nil result")
    }

    func testPostIncrement() throws {
        
        if !AuthManager.share.isAuth() { return }
        let factory = ApiFactory.makeUserRatesApi()
        let request = "postIncrement"
        var response: UserRatesDTO?
        var error: String?
        let expectation = self.expectation(description: "\(api2Test).\(request) expectation timeout")

        ApiFactory.makeUsersApi().whoAmI { user, _ in
            if let user {
                Timer.scheduledTimer(withTimeInterval: self.delayRequests, repeats: false) { _ in
                    ApiFactory.makeAnimesApi().getAnimes(page: 1, limit: 5, search: "Hero") { animes, _ in
                        if let anime = animes?.first {
                            Timer.scheduledTimer(withTimeInterval: self.delayRequests, repeats: false) { _ in
                                factory.postEntity(
                                    userId: user.id,
                                    targetId: anime.id,
                                    targetType: .anime
                                ) { entity, errorString in
                                    if let entity {
                                        Timer.scheduledTimer(
                                            withTimeInterval: self.delayRequests,
                                            repeats: false
                                        ) { _ in
                                            factory.postIncrement(id: entity.id) { entity, errorString in
                                                response = entity
                                                error = errorString
                                                expectation.fulfill()
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        waitForExpectations(timeout: 45)
        XCTAssertNil(error, "Unexpected \(api2Test).\(request) error \(error ?? "")")
        XCTAssertNotNil(response, "Unexpected \(api2Test).\(request) nil result")
    }

    func testDeleteEntity() throws {
        
        if !AuthManager.share.isAuth() { return }
        let factory = ApiFactory.makeUserRatesApi()
        let request = "deleteEntity"
        var response: String?
        var error: String?
        let expectation = self.expectation(description: "\(api2Test).\(request) expectation timeout")

        ApiFactory.makeUsersApi().whoAmI { user, _ in
            if let user {
                Timer.scheduledTimer(withTimeInterval: self.delayRequests, repeats: false) { _ in
                    ApiFactory.makeAnimesApi().getAnimes(page: 1, limit: 5, search: "Hero") { animes, _ in
                        if let anime = animes?.first {
                            Timer.scheduledTimer(withTimeInterval: self.delayRequests, repeats: false) { _ in
                                factory.postEntity(
                                    userId: user.id,
                                    targetId: anime.id,
                                    targetType: .anime
                                ) { entity, errorString in
                                    if let entity {
                                        Timer.scheduledTimer(
                                            withTimeInterval: self.delayRequests,
                                            repeats: false
                                        ) { _ in
                                            factory.deleteEntity(id: entity.id) { entity, errorString in
                                                response = entity
                                                error = errorString
                                                expectation.fulfill()
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        waitForExpectations(timeout: 45)
        XCTAssertNil(error, "Unexpected \(api2Test).\(request) error \(error ?? "")")
        XCTAssertNotNil(response, "Unexpected \(api2Test).\(request) nil result")
    }

    func testPutEntity() throws {
        
        if !AuthManager.share.isAuth() { return }
        let factory = ApiFactory.makeUserRatesApi()
        let request = "putEntity"
        var response: UserRatesDTO?
        var error: String?
        let expectation = self.expectation(description: "\(api2Test).\(request) expectation timeout")

        ApiFactory.makeUsersApi().whoAmI { user, _ in
            if let user {
                Timer.scheduledTimer(withTimeInterval: self.delayRequests, repeats: false) { _ in
                    ApiFactory.makeAnimesApi().getAnimes(page: 1, limit: 50) { animes, _ in
                        if let anime = animes?.first {
                            Timer.scheduledTimer(withTimeInterval: self.delayRequests, repeats: false) { _ in
                                factory.postEntity(
                                    userId: user.id,
                                    targetId: anime.id,
                                    targetType: .anime
                                ) { entity, errorString in
                                    if let entity {
                                        let state = UserRatesState(
                                            status: .watching,
                                            score: 0,
                                            chapters: 0,
                                            episodes: 1,
                                            volumes: 1,
                                            rewatches: 0,
                                            text: "qqwerty"
                                        )
                                        Timer.scheduledTimer(
                                            withTimeInterval: self.delayRequests,
                                            repeats: false
                                        ) { _ in
                                            factory.putEntity(id: entity.id, state: state) { entity, errorString in
                                                response = entity
                                                error = errorString
                                                expectation.fulfill()
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        waitForExpectations(timeout: 15)
        XCTAssertNil(error, "Unexpected \(api2Test).\(request) error \(error ?? "")")
        XCTAssertNotNil(response, "Unexpected \(api2Test).\(request) nil result")
    }
}
