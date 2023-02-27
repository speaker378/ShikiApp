//
//  RanobeApiTests.swift
//  ShikiAppTests
//
//  Created by Алексей Шинкарев on 01.02.2023.
//

import Foundation
@testable import ShikiApp
import XCTest

final class RanobeApiTests: XCTestCase {
    
    let delayRequests = 1.0
    private let api2Test = "RanobeRequestFactory"

    override func setUpWithError() throws {
        try? super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try? super.tearDownWithError()
    }

    func testListRanobe() throws {
        
        let factory = ApiFactory.makeRanobeApi()
        let request = "listRanobe"
        let filters = RanobeListFilters(
            status: .released,
            season: "2022",
            score: 1,
            genre: []
        )
        var response: RanobeResponseDTO?
        var error: String?
        let expectation = self.expectation(description: "\(api2Test).\(request) expectation timeout")
        
        factory.getRanobes(
            page: 1,
            limit: 10,
            filters: filters,
            order: .byPopularity
        ) { data, errorMessage in
            response = data
            error = errorMessage
            expectation.fulfill()
        }
        waitForExpectations(timeout: 15)
        XCTAssertNil(error, "Unexpected \(api2Test).\(request) error \(error ?? "")")
        XCTAssertNotNil(response, "Unexpected \(api2Test).\(request) nil result")
    }
    
    func testGetRanobe() throws {
        
        let factory = ApiFactory.makeRanobeApi()
        let request = "getRanobe"
        var response: RanobeDetailsDTO?
        var error: String?
        let expectation = self.expectation(description: "\(api2Test).\(request) expectation timeout")
        
        factory.getRanobes { data, errorMessage in
            guard let id = data?.first?.id else { return }
            Timer.scheduledTimer(withTimeInterval: self.delayRequests, repeats: false) { _ in
                factory.getRanobeById(id: id) { data, errorMessage in
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
