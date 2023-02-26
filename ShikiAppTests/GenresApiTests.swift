//
//  GenresApiTests.swift
//  ShikiAppTests
//
//  Created by Алексей Шинкарев on 19.02.2023.
//

@testable import ShikiApp
import XCTest

final class GenresApiTests: XCTestCase {
    
    private let factory = ApiFactory.makeGenresApi()
    private let api2Test = "GenresRequestFactory"
    
    override func setUpWithError() throws {
        try? super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try? super.tearDownWithError()
    }
    
    func testListGenres() throws {
        let request = "getList"
        var response: GenreResponseDTO?
        var error: String?
        let expectation = self.expectation(description: "\(api2Test).\(request) expectation timeout")
        factory.getList { data, errorMessage in
            response = data
            error = errorMessage
            expectation.fulfill()
        }
        waitForExpectations(timeout: 15)
        XCTAssertNil(error, "Unexpected \(api2Test).\(request) error \(error ?? "")")

        XCTAssertNotNil(response, "Unexpected \(api2Test).\(request) nil result")
    }
}
