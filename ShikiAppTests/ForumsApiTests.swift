//
//  ForumsApiTests.swift
//  ShikiAppTests
//
//  Created by Алексей Шинкарев on 18.01.2023.
//

@testable import ShikiApp
import XCTest

final class ForumsApiTests: XCTestCase {

    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}
    
    func testForumsRequests() throws {
        let factory = ApiFactory.makeForumsApi()
        var forums: ForumsResponseDTO?
        var error: String?
        let expectation = self.expectation(description: "ForumsRequestFactory.getForums expectation timeout")
        factory.listForums { forumsResponse, errorMessage in
            forums = forumsResponse
            error = errorMessage
            expectation.fulfill()
        }
        waitForExpectations(timeout: 15)
        XCTAssertNil(error, "Unexpected ForumsRequestFactory.getForums error \(error ?? "")")

        XCTAssertFalse(forums?.isEmpty ?? true, "Unexpected ForumsRequestFactory.getForums empty or nil result")
    }

}
