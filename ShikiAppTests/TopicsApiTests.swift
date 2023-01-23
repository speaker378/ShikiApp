//
//  TopicsApiTests.swift
//  ShikiAppTests
//
//  Created by Алексей Шинкарев on 23.01.2023.
//

@testable import ShikiApp
import XCTest

final class TopicsApiTests: XCTestCase {
    private let factory = ApiFactory.makeTopicsApi()
    private let api2Test = "TopicsRequestFactory"
    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func testlistTopics() throws {
        let request = "listTopics"
        var response: TopicsResponse?
        var error: String?
        let expectation = self.expectation(description: "\(api2Test).\(request) expectation timeout")
        factory.listTopics(page: 1,
                           limit: 10,
                           forum: .all,
                           type: .topic) { data, errorMessage in
            response = data
            error = errorMessage
            expectation.fulfill()
        }

        waitForExpectations(timeout: 15)
        XCTAssertNil(error, "Unexpected \(api2Test).\(request) error \(error ?? "")")

        XCTAssertFalse(response?.isEmpty ?? true, "Unexpected \(api2Test).\(request) empty or nil result")
    }

    func testHotTopics() throws {
        let request = "hotTopics"
        var response: TopicsResponse?
        var error: String?
        let expectation = self.expectation(description: "\(api2Test).\(request) expectation timeout")
        factory.hotTopics(limit: 10) { data, errorMessage in
            response = data
            error = errorMessage
            expectation.fulfill()
        }

        waitForExpectations(timeout: 15)
        XCTAssertNil(error, "Unexpected \(api2Test).\(request) error \(error ?? "")")

        XCTAssertFalse(response?.isEmpty ?? true, "Unexpected \(api2Test).\(request) empty or nil result")
    }

    func testNewTopics() throws {
        let request = "newTopics"
        var response: NewsTopicsResponse?
        var error: String?
        let expectation = self.expectation(description: "\(api2Test).\(request) expectation timeout")
        factory.newTopics(page: 1,
                          limit: 10) { data, errorMessage in
            response = data
            error = errorMessage
            expectation.fulfill()
        }

        waitForExpectations(timeout: 15)
        XCTAssertNil(error, "Unexpected \(api2Test).\(request) error \(error ?? "")")

        XCTAssertFalse(response?.isEmpty ?? true, "Unexpected \(api2Test).\(request) empty or nil result")
    }
    
}
