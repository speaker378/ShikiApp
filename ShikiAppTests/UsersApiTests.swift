//
//  UsersApiTests.swift
//  ShikiAppTests
//
//  Created by Алексей Шинкарев on 24.01.2023.
//

@testable import ShikiApp
import XCTest

final class UsersApiTests: XCTestCase {
    private let factory = ApiFactory.makeUsersApi()
    private let api2Test = "UsersRequestFactory"

    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func testListUsers() throws {
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
        let request = "getUserById"
        var response: UserProfileDTO?
        var error: String?
        let expectation = self.expectation(description: "\(api2Test).\(request) expectation timeout")
        factory.getUsers(page: 1, limit: 10) { data, errorMessage in
            if let id = data?.first?.nickname {
                self.factory.getUserByNickName(nick: id) { data, errorMessage in
                    response = data
                    error = errorMessage
                    expectation.fulfill()
                }
            }
        }
        waitForExpectations(timeout: 15)
        XCTAssertNil(error, "Unexpected \(api2Test).\(request) error \(error ?? "")")
        XCTAssertNotNil(response, "Unexpected \(api2Test).\(request) nil result")
    }

    func testGetUserById() throws {
        let request = "getUserById"
        var response: UserProfileDTO?
        var error: String?
        let expectation = self.expectation(description: "\(api2Test).\(request) expectation timeout")
        factory.getUsers(page: 1, limit: 10) { data, errorMessage in
            if let id = data?.first?.id {
                self.factory.getUserById(id: id) { data, errorMessage in
                    response = data
                    error = errorMessage
                    expectation.fulfill()
                }
            }
        }
        waitForExpectations(timeout: 15)
        XCTAssertNil(error, "Unexpected \(api2Test).\(request) error \(error ?? "")")
        XCTAssertNotNil(response, "Unexpected \(api2Test).\(request) nil result")
    }

    func testGetUserInfo() throws {
        let request = "getUserInfo"
        var response: UserDTO?
        var error: String?
        let expectation = self.expectation(description: "\(api2Test).\(request) expectation timeout")
        factory.getUsers(page: 1, limit: 10) { data, errorMessage in
            if let id = data?.first?.id {
                self.factory.getUserInfo(id: id) { data, errorMessage in
                    response = data
                    error = errorMessage
                    expectation.fulfill()
                }
            }
        }
        waitForExpectations(timeout: 15)
        XCTAssertNil(error, "Unexpected \(api2Test).\(request) error \(error ?? "")")
        XCTAssertNotNil(response, "Unexpected \(api2Test).\(request) nil result")
    }

    func testWhoAmI() throws {
        if !AuthManager.share.isAuth() { return }
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
        let request = "getUserFriends"
        var response: FriendsResponseDTO?
        var error: String?
        let expectation = self.expectation(description: "\(api2Test).\(request) expectation timeout")
        factory.whoAmI { data, errorMessage in
            if let id = data?.id {
                self.factory.getFriends(id: id) { data, errorMessage in
                    response = data
                    error = errorMessage
                    expectation.fulfill()
                }
            }
        }
        waitForExpectations(timeout: 15)
        XCTAssertNil(error, "Unexpected \(api2Test).\(request) error \(error ?? "")")
        XCTAssertNotNil(response, "Unexpected \(api2Test).\(request) nil result")
    }
    
    func testGetUserClubs() throws {
        if !AuthManager.share.isAuth() { return }
        let request = "getUserClubs"
        var response: ClubsResponseDTO?
        var error: String?
        let expectation = self.expectation(description: "\(api2Test).\(request) expectation timeout")
        factory.whoAmI { data, errorMessage in
            if let id = data?.id {
                self.factory.getClubs(id: id) { data, errorMessage in
                    response = data
                    error = errorMessage
                    expectation.fulfill()
                }
            }
        }
        waitForExpectations(timeout: 15)
        XCTAssertNil(error, "Unexpected \(api2Test).\(request) error \(error ?? "")")
        XCTAssertNotNil(response, "Unexpected \(api2Test).\(request) nil result")
    }
    
    func testGetUserAnimeRates() throws {
        if !AuthManager.share.isAuth() { return }
        let request = "getUserAnimeRates"
        var response: AnimeRatesResponseDTO?
        var error: String?
        let expectation = self.expectation(description: "\(api2Test).\(request) expectation timeout")
        factory.whoAmI { data, errorMessage in
            if let id = data?.id {
                self.factory.getAnimeRates(id: id, status: nil, isCensored: true) { data, errorMessage in
                    response = data
                    error = errorMessage
                    expectation.fulfill()
                }
            }
        }
        waitForExpectations(timeout: 15)
        XCTAssertNil(error, "Unexpected \(api2Test).\(request) error \(error ?? "")")
        XCTAssertNotNil(response, "Unexpected \(api2Test).\(request) nil result")
    }
    
    func testGetUserFavorites() throws {
        if !AuthManager.share.isAuth() { return }
        let request = "getUserFavorites"
        var response: UserFavoritesResponseDTO?
        var error: String?
        let expectation = self.expectation(description: "\(api2Test).\(request) expectation timeout")
        factory.whoAmI { data, errorMessage in
            if let id = data?.id {
                self.factory.getFavorites(id: id) { data, errorMessage in
                    response = data
                    error = errorMessage
                    expectation.fulfill()
                }
            }
        }
        waitForExpectations(timeout: 15)
        XCTAssertNil(error, "Unexpected \(api2Test).\(request) error \(error ?? "")")
        XCTAssertNotNil(response, "Unexpected \(api2Test).\(request) nil result")
    }
    
    func testGetUserMangaRates() throws {
        if !AuthManager.share.isAuth() { return }
        let request = "getUserMangaRates"
        var response: MangaRatesResponseDTO?
        var error: String?
        let expectation = self.expectation(description: "\(api2Test).\(request) expectation timeout")
        factory.whoAmI { data, errorMessage in
            if let id = data?.id {
                self.factory.getMangaRates(id: id, isCensored: true) { data, errorMessage in
                    response = data
                    error = errorMessage
                    expectation.fulfill()
                }
            }
        }
        waitForExpectations(timeout: 15)
        XCTAssertNil(error, "Unexpected \(api2Test).\(request) error \(error ?? "")")
        XCTAssertNotNil(response, "Unexpected \(api2Test).\(request) nil result")
    }
    
    func testGetUserMessages() throws {
        if !AuthManager.share.isAuth() { return }
        let request = "getUserMessages"
        var response: MessagesResponseDTO?
        var error: String?
        let expectation = self.expectation(description: "\(api2Test).\(request) expectation timeout")
        factory.whoAmI { data, errorMessage in
            if let id = data?.id {
                self.factory.getMessages(id: id, type: .news) { data, errorMessage in
                    response = data
                    error = errorMessage
                    expectation.fulfill()
                }
            }
        }
        waitForExpectations(timeout: 15)
        XCTAssertNil(error, "Unexpected \(api2Test).\(request) error \(error ?? "")")
        XCTAssertNotNil(response, "Unexpected \(api2Test).\(request) nil result")
    }
    
    func testGetUnreadMessages() throws {
        if !AuthManager.share.isAuth() { return }
        let request = "getUnreadMessages"
        var response: UnreadMessagesResponseDTO?
        var error: String?
        let expectation = self.expectation(description: "\(api2Test).\(request) expectation timeout")
        factory.whoAmI { data, errorMessage in
            if let id = data?.id {
                self.factory.getUnreadMessages(id: id) { data, errorMessage in
                    response = data
                    error = errorMessage
                    expectation.fulfill()
                }
            }
        }
        waitForExpectations(timeout: 15)
        XCTAssertNil(error, "Unexpected \(api2Test).\(request) error \(error ?? "")")
        XCTAssertNotNil(response, "Unexpected \(api2Test).\(request) nil result")
    }
    
    func testGetHistory() throws {
        if !AuthManager.share.isAuth() { return }
        let request = "getHistory"
        var response: UserHistoryResponseDTO?
        var error: String?
        let expectation = self.expectation(description: "\(api2Test).\(request) expectation timeout")
        factory.whoAmI { data, errorMessage in
            if let id = data?.id {
                self.factory.getHistory(id: id, type: .anime) { data, errorMessage in
                    response = data
                    error = errorMessage
                    expectation.fulfill()
                }
            }
        }
        waitForExpectations(timeout: 15)
        XCTAssertNil(error, "Unexpected \(api2Test).\(request) error \(error ?? "")")
        XCTAssertNotNil(response, "Unexpected \(api2Test).\(request) nil result")
    }
    
    func testGetBans() throws {
        if !AuthManager.share.isAuth() { return }
        let request = "getBans"
        var response: BansResponseDTO?
        var error: String?
        let expectation = self.expectation(description: "\(api2Test).\(request) expectation timeout")
        factory.whoAmI { data, errorMessage in
            if let id = data?.id {
                self.factory.getBans(id: id) { data, errorMessage in
                    response = data
                    error = errorMessage
                    expectation.fulfill()
                }
            }
        }
        waitForExpectations(timeout: 15)
        XCTAssertNil(error, "Unexpected \(api2Test).\(request) error \(error ?? "")")
        XCTAssertNotNil(response, "Unexpected \(api2Test).\(request) nil result")
    }
}
