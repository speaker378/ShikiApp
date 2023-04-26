//
//  UsersApiTests.swift
//  ShikiAppTests
//
//  Created by Алексей Шинкарев on 24.01.2023.
//

@testable import ShikiApp
import XCTest

final class UsersApiTests: XCTestCase {
    
    private let delayRequests = 1.0
    private let api2Test = "UsersRequestFactory"

    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func testListUsers() throws {
        
        let factory = ApiFactory.makeUsersApi()
        let request = "getUsers"
        var response: UsersResponseDTO?
        var error: String?
        let expectation = self.expectation(description: "\(api2Test).\(request) expectation timeout")

        factory.getUsers(page: 1, limit: 10) { data, errorMessage in
            response = data
            error = errorMessage
            expectation.fulfill()
        }
        waitForExpectations(timeout: 15)
        XCTAssertNil(error, "Unexpected \(api2Test).\(request) error \(error ?? "")")
        XCTAssertFalse(response?.isEmpty ?? true, "Unexpected \(api2Test).\(request) empty or nil result")
    }

    func testGetUserByNick() throws {
        
        let factory = ApiFactory.makeUsersApi()
        let request = "getUserById"
        var response: UserProfileDTO?
        var error: String?
        let expectation = self.expectation(description: "\(api2Test).\(request) expectation timeout")

        factory.whoAmI { data, errorMessage in
            if let id = data?.nickname {
                Timer.scheduledTimer(withTimeInterval: self.delayRequests, repeats: false) { _ in
                    factory.getUserByNickName(nick: id) { data, errorMessage in
                        response = data
                        error = errorMessage
                        expectation.fulfill()
                    }
                }
            }
        }
        waitForExpectations(timeout: 15)
        XCTAssertNil(error, "Unexpected \(api2Test).\(request) error \(error ?? "")")
        XCTAssertNotNil(response, "Unexpected \(api2Test).\(request) nil result")
    }

    func testGetUserById() throws {
        
        let factory = ApiFactory.makeUsersApi()
        let request = "getUserById"
        var response: UserProfileDTO?
        var error: String?
        let expectation = self.expectation(description: "\(api2Test).\(request) expectation timeout")

        factory.whoAmI { data, errorMessage in
            if let id = data?.id {
                Timer.scheduledTimer(withTimeInterval: self.delayRequests, repeats: false) { _ in
                    factory.getUserById(id: id) { data, errorMessage in
                        response = data
                        error = errorMessage
                        expectation.fulfill()
                    }
                }
            }
        }
        waitForExpectations(timeout: 15)
        XCTAssertNil(error, "Unexpected \(api2Test).\(request) error \(error ?? "")")
        XCTAssertNotNil(response, "Unexpected \(api2Test).\(request) nil result")
    }

    func testGetUserInfo() throws {
        
        let factory = ApiFactory.makeUsersApi()
        let request = "getUserInfo"
        var response: UserDTO?
        var error: String?
        let expectation = self.expectation(description: "\(api2Test).\(request) expectation timeout")

        factory.whoAmI { data, errorMessage in
            if let id = data?.id {
                Timer.scheduledTimer(withTimeInterval: self.delayRequests, repeats: false) {_ in
                    factory.getUserInfo(id: id) { data, errorMessage in
                        response = data
                        error = errorMessage
                        expectation.fulfill()
                    }
                }
            }
        }
        waitForExpectations(timeout: 15)
        XCTAssertNil(error, "Unexpected \(api2Test).\(request) error \(error ?? "")")
        XCTAssertNotNil(response, "Unexpected \(api2Test).\(request) nil result")
    }

    func testWhoAmI() throws {
        
        if !AuthManager.share.isAuth() { return }
        let factory = ApiFactory.makeUsersApi()
        let request = "whoAmI"
        var response: UserDTO?
        var error: String?
        let expectation = self.expectation(description: "\(api2Test).\(request) expectation timeout")

        factory.whoAmI { data, errorMessage in
            response = data
            error = errorMessage
            expectation.fulfill()
        }
        waitForExpectations(timeout: 15)
        XCTAssertNil(error, "Unexpected \(api2Test).\(request) error \(error ?? "")")
        XCTAssertNotNil(response, "Unexpected \(api2Test).\(request) nil result")
    }

    func testGetUserFriends() throws {
        
        if !AuthManager.share.isAuth() { return }
        let factory = ApiFactory.makeUsersApi()
        let request = "getUserFriends"
        var response: FriendsResponseDTO?
        var error: String?
        let expectation = self.expectation(description: "\(api2Test).\(request) expectation timeout")

        factory.whoAmI { data, errorMessage in
            if let id = data?.id {
                Timer.scheduledTimer(withTimeInterval: self.delayRequests, repeats: false) { _ in
                    factory.getFriends(id: id) { data, errorMessage in
                        response = data
                        error = errorMessage
                        expectation.fulfill()
                    }
                }
            }
        }
        waitForExpectations(timeout: 15)
        XCTAssertNil(error, "Unexpected \(api2Test).\(request) error \(error ?? "")")
        XCTAssertNotNil(response, "Unexpected \(api2Test).\(request) nil result")
    }

    func testGetUserClubs() throws {
        
        if !AuthManager.share.isAuth() { return }

        let factory = ApiFactory.makeUsersApi()
        let request = "getUserClubs"
        var response: ClubsResponseDTO?
        var error: String?
        let expectation = self.expectation(description: "\(api2Test).\(request) expectation timeout")

        factory.whoAmI { data, errorMessage in
            if let id = data?.id {
                Timer.scheduledTimer(withTimeInterval: self.delayRequests, repeats: false) { _ in
                    factory.getClubs(id: id) { data, errorMessage in
                        response = data
                        error = errorMessage
                        expectation.fulfill()
                    }
                }
            }
        }
        waitForExpectations(timeout: 15)
        XCTAssertNil(error, "Unexpected \(api2Test).\(request) error \(error ?? "")")
        XCTAssertNotNil(response, "Unexpected \(api2Test).\(request) nil result")
    }

    func testGetUserAnimeRates() throws {
        
        if !AuthManager.share.isAuth() { return }
        let factory = ApiFactory.makeUsersApi()
        let request = "getUserAnimeRates"
        var response: AnimeRatesResponseDTO?
        var error: String?
        let expectation = self.expectation(description: "\(api2Test).\(request) expectation timeout")

        factory.whoAmI { data, errorMessage in
            if let id = data?.id {
                Timer.scheduledTimer(withTimeInterval: self.delayRequests, repeats: false) { _ in
                    factory.getAnimeRates(id: id, status: nil, isCensored: true) { data, errorMessage in
                        response = data
                        error = errorMessage
                        expectation.fulfill()
                    }
                }
            }
        }
        waitForExpectations(timeout: 15)
        XCTAssertNil(error, "Unexpected \(api2Test).\(request) error \(error ?? "")")
        XCTAssertNotNil(response, "Unexpected \(api2Test).\(request) nil result")
    }

    func testGetUserFavorites() throws {
        
        if !AuthManager.share.isAuth() { return }
        let factory = ApiFactory.makeUsersApi()
        let request = "getUserFavorites"
        var response: UserFavoritesResponseDTO?
        var error: String?
        let expectation = self.expectation(description: "\(api2Test).\(request) expectation timeout")

        factory.whoAmI { data, errorMessage in
            if let id = data?.id {
                Timer.scheduledTimer(withTimeInterval: self.delayRequests, repeats: false) { _ in
                    factory.getFavorites(id: id) { data, errorMessage in
                        response = data
                        error = errorMessage
                        expectation.fulfill()
                    }
                }
            }
        }
        waitForExpectations(timeout: 15)
        XCTAssertNil(error, "Unexpected \(api2Test).\(request) error \(error ?? "")")
        XCTAssertNotNil(response, "Unexpected \(api2Test).\(request) nil result")
    }

    func testGetUserMangaRates() throws {
        
        if !AuthManager.share.isAuth() { return }
        let factory = ApiFactory.makeUsersApi()
        let request = "getUserMangaRates"
        var response: MangaRatesResponseDTO?
        var error: String?
        let expectation = self.expectation(description: "\(api2Test).\(request) expectation timeout")

        factory.whoAmI { data, errorMessage in
            if let id = data?.id {
                Timer.scheduledTimer(withTimeInterval: self.delayRequests, repeats: false) { _ in
                    factory.getMangaRates(id: id, status: nil, isCensored: true) { data, errorMessage in
                        response = data
                        error = errorMessage
                        expectation.fulfill()
                    }
                }
            }
        }
        waitForExpectations(timeout: 15)
        XCTAssertNil(error, "Unexpected \(api2Test).\(request) error \(error ?? "")")
        XCTAssertNotNil(response, "Unexpected \(api2Test).\(request) nil result")
    }

    func testGetUserMessages() throws {
        
        if !AuthManager.share.isAuth() { return }
        let factory = ApiFactory.makeUsersApi()
        let request = "getUserMessages"
        var response: MessagesResponseDTO?
        var error: String?
        let expectation = self.expectation(description: "\(api2Test).\(request) expectation timeout")

        factory.whoAmI { data, errorMessage in
            if let id = data?.id {
                Timer.scheduledTimer(withTimeInterval: self.delayRequests, repeats: false) { _ in
                    factory.getMessages(id: id, type: .news) { data, errorMessage in
                        response = data
                        error = errorMessage
                        expectation.fulfill()
                    }
                }
            }
        }
        waitForExpectations(timeout: 45)
        XCTAssertNil(error, "Unexpected \(api2Test).\(request) error \(error ?? "")")
        XCTAssertNotNil(response, "Unexpected \(api2Test).\(request) nil result")
    }

    func testGetUnreadMessages() throws {
        
        if !AuthManager.share.isAuth() { return }
        let factory = ApiFactory.makeUsersApi()
        let request = "getUnreadMessages"
        var response: UnreadMessagesResponseDTO?
        var error: String?
        let expectation = self.expectation(description: "\(api2Test).\(request) expectation timeout")

        factory.whoAmI { data, errorMessage in
            if let id = data?.id {
                Timer.scheduledTimer(withTimeInterval: self.delayRequests, repeats: false) { _ in
                    factory.getUnreadMessages(id: id) { data, errorMessage in
                        response = data
                        error = errorMessage
                        expectation.fulfill()
                    }
                }
            }
        }
        waitForExpectations(timeout: 15)
        XCTAssertNil(error, "Unexpected \(api2Test).\(request) error \(error ?? "")")
        XCTAssertNotNil(response, "Unexpected \(api2Test).\(request) nil result")
    }

    func testGetHistory() throws {
        
        if !AuthManager.share.isAuth() { return }
        let factory = ApiFactory.makeUsersApi()
        let request = "getHistory"
        var response: UserHistoryResponseDTO?
        var error: String?
        let expectation = self.expectation(description: "\(api2Test).\(request) expectation timeout")

        factory.whoAmI { data, errorMessage in
            if let id = data?.id {
                Timer.scheduledTimer(withTimeInterval: self.delayRequests, repeats: false) { _ in
                    factory.getHistory(id: id, type: .anime) { data, errorMessage in
                        response = data
                        error = errorMessage
                        expectation.fulfill()
                    }
                }
            }
        }
        waitForExpectations(timeout: 15)
        XCTAssertNil(error, "Unexpected \(api2Test).\(request) error \(error ?? "")")
        XCTAssertNotNil(response, "Unexpected \(api2Test).\(request) nil result")
    }

    func testGetBans() throws {
        
        if !AuthManager.share.isAuth() { return }
        let factory = ApiFactory.makeUsersApi()
        let request = "getBans"
        var response: BansResponseDTO?
        var error: String?
        let expectation = self.expectation(description: "\(api2Test).\(request) expectation timeout")

        factory.whoAmI { data, errorMessage in
            if let id = data?.id {
                Timer.scheduledTimer(withTimeInterval: self.delayRequests, repeats: false) { _ in
                    factory.getBans(id: id) { data, errorMessage in
                        response = data
                        error = errorMessage
                        expectation.fulfill()
                    }
                }
            }
        }
        waitForExpectations(timeout: 15)
        XCTAssertNil(error, "Unexpected \(api2Test).\(request) error \(error ?? "")")
        XCTAssertNotNil(response, "Unexpected \(api2Test).\(request) nil result")
    }
}
