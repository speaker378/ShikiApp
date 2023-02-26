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
    private let factory = ApiFactory.makeUserRatesApi()
    private let api2Test = "UserRatesRequestFactory"

    override func setUpWithError() throws {
        try? super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try? super.tearDownWithError()
    }

    func testGetEntityList() throws {
        let request = "getList"
        var response: UserRatesResponseDTO?
        var error: String?
        let expectation = self.expectation(description: "\(api2Test).\(request) expectation timeout")
        ApiFactory.makeUsersApi().getUsers(page: 1, limit: 10) { users, _ in
            if let userId = users?.first?.id {
                self.factory.getList(page: 1, limit: 100, userId: userId) { data, errorString in
                    response = data
                    error = errorString
                    expectation.fulfill()
                }
            }
        }
        waitForExpectations(timeout: 15)
        XCTAssertNil(error, "Unexpected \(api2Test).\(request) error \(error ?? "")")
        XCTAssertNotNil(response, "Unexpected \(api2Test).\(request) nil result")
    }

    func testGetEntity() throws {
        let request = "getById"
        var response: UserRatesDTO?
        var error: String?
        let expectation = self.expectation(description: "\(api2Test).\(request) expectation timeout")
        ApiFactory.makeUsersApi().getUsers(page: 1, limit: 10) { users, _ in
            if let users {
                for user in users {
                    self.factory.getList(page: 1, limit: 1000, userId: user.id) { rates, _ in
                        if let rates {
                            for rate in rates {
                                self.factory.getById(id: rate.id) { data, errorString in
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
        let request = "postEntity"
        var response: UserRatesDTO?
        var error: String?
        let expectation = self.expectation(description: "\(api2Test).\(request) expectation timeout")
        ApiFactory.makeUsersApi().whoAmI { user, _ in
            if let user {
                ApiFactory.makeAnimesApi().getAnimes(page: 1, limit: 50) { animes, _ in
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
                        self.factory.postEntity(
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
        waitForExpectations(timeout: 15)
        XCTAssertNil(error, "Unexpected \(api2Test).\(request) error \(error ?? "")")
        XCTAssertNotNil(response, "Unexpected \(api2Test).\(request) nil result")
    }

    func testPostIncrement() throws {
        if !AuthManager.share.isAuth() { return }
        let request = "postIncrement"
        var response: UserRatesDTO?
        var error: String?
        let expectation = self.expectation(description: "\(api2Test).\(request) expectation timeout")
        ApiFactory.makeUsersApi().whoAmI { user, _ in
            if let user {
                ApiFactory.makeAnimesApi().getAnimes(page: 1, limit: 50) { animes, _ in
                    if let anime = animes?.first {
                        self.factory.postEntity(
                            userId: user.id,
                            targetId: anime.id,
                            targetType: .anime
                        ) { entity, errorString in
                            if let entity {
                                self.factory.postIncrement(id: entity.id) { entity, errorString in
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
        waitForExpectations(timeout: 15)
        XCTAssertNil(error, "Unexpected \(api2Test).\(request) error \(error ?? "")")
        XCTAssertNotNil(response, "Unexpected \(api2Test).\(request) nil result")
    }

    func testDeleteEntity() throws {
        if !AuthManager.share.isAuth() { return }
        let request = "deleteEntity"
        var response: String?
        var error: String?
        let expectation = self.expectation(description: "\(api2Test).\(request) expectation timeout")
        ApiFactory.makeUsersApi().whoAmI { user, _ in
            if let user {
                ApiFactory.makeAnimesApi().getAnimes(page: 1, limit: 50) { animes, _ in
                    if let anime = animes?.first {
                        self.factory.postEntity(
                            userId: user.id,
                            targetId: anime.id,
                            targetType: .anime
                        ) { entity, errorString in
                            if let entity {
                                self.factory.deleteEntity(id: entity.id) { entity, errorString in
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
        waitForExpectations(timeout: 15)
        XCTAssertNil(error, "Unexpected \(api2Test).\(request) error \(error ?? "")")
        XCTAssertNotNil(response, "Unexpected \(api2Test).\(request) nil result")
    }

    func testPutEntity() throws {
        if !AuthManager.share.isAuth() { return }
        let request = "putEntity"
        var response: UserRatesDTO?
        var error: String?
        let expectation = self.expectation(description: "\(api2Test).\(request) expectation timeout")
        ApiFactory.makeUsersApi().whoAmI { user, _ in
            if let user {
                ApiFactory.makeAnimesApi().getAnimes(page: 1, limit: 50) { animes, _ in
                    if let anime = animes?.first {
                        self.factory.postEntity(
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
                                self.factory.putEntity(id: entity.id, state: state) { entity, errorString in
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
        waitForExpectations(timeout: 15)
        XCTAssertNil(error, "Unexpected \(api2Test).\(request) error \(error ?? "")")
        XCTAssertNotNil(response, "Unexpected \(api2Test).\(request) nil result")
    }
}
