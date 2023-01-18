//
//  NetworkLayerTests.swift
//  ShikiAppTests
//
//  Created by Алексей Шинкарев on 18.01.2023.
//

import Foundation
@testable import ShikiApp
import XCTest

final class NetworkLayerTests: XCTestCase {
    private let token = "BrNsXGRgVpu_w3TVM8C1LgCbJTuYYZbffZh2TMng8vw"
    private let agent = "Shiki-ios"

    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func testForumsRequests() throws {
//        let factory = ForumsRequestFactory(token: token, agent: agent)
        let factory = ForumsRequestFactory(token: nil, agent: agent)
        var forums: ForumsResponse?
        var error: String?
        let expectation = self.expectation(description: "ForumsRequestFactory.getForums expectation timeout")
        factory.getForums { forumsResponse, errorMessage in
            forums = forumsResponse
            error = errorMessage
            expectation.fulfill()
        }
        waitForExpectations(timeout: 15)
        XCTAssertNil(error, "Unexpected ForumsRequestFactory.getForums error \(error ?? "")")

        XCTAssertFalse(forums?.isEmpty ?? true, "Unexpected ForumsRequestFactory.getForums empty or nil result")
    }

    func testPerformanceExample() throws {
        self.measure {}
    }
}
