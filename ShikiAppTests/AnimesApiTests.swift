//
//  AnimesApiTests.swift
//  ShikiAppTests
//
//  Created by Алексей Шинкарев on 30.01.2023.
//

@testable import ShikiApp
import XCTest

final class AnimesApiTests: XCTestCase {
    
    let delayRequests = 1.0
    private let api2Test = "AnimesRequestFactory"

    override func setUpWithError() throws {
        try? super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try? super.tearDownWithError()
    }

    func testListAnimes() throws {
        
        let factory = ApiFactory.makeAnimesApi()
        let request = "listAnimes"
        let filters = AnimeListFilters(
            kind: .movie,
            status: .released,
            season: "2022",
            score: 6,
            genre: [8]
        )
        var response: AnimesResponseDTO?
        var error: String?
        let expectation = self.expectation(description: "\(api2Test).\(request) expectation timeout")

        factory.getAnimes(
            page: 1,
            limit: 10,
            filters: filters,
            search: "Hero",
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

    func testGetAnime() throws {
        
        let factory = ApiFactory.makeAnimesApi()
        let request = "getAnime"
        var response: AnimeDetailsDTO?
        var error: String?
        let expectation = self.expectation(description: "\(api2Test).\(request) expectation timeout")

        factory.getAnimes { data, errorMessage in
            guard let id = data?.first?.id else { return }
            Timer.scheduledTimer(withTimeInterval: self.delayRequests, repeats: false) { _ in
                factory.getAnimeById(id: id) { data, errorMessage in
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
