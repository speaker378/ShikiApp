//
//  MangasApiTests.swift
//  ShikiAppTests
//
//  Created by Алексей Шинкарев on 01.02.2023.
//

@testable import ShikiApp
import XCTest

final class MangasApiTests: XCTestCase {
    private let factory = ApiFactory.makeMangasApi()
    private let api2Test = "MangasRequestFactory"

    override func setUpWithError() throws {
        try? super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try? super.tearDownWithError()
    }

    func testListMangas() throws {
        let request = "listMangas"
        let filters = MangaListFilters(
            kind: .manga,
            status: .released,
            season: "2022",
            score: 6,
            genre: [89]
        )
        var response: MangaResponseDTO?
        var error: String?
        let expectation = self.expectation(description: "\(api2Test).\(request) expectation timeout")
        factory.getMangas(
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
    
    func testGetManga() throws {
        let request = "getManga"

        var response: MangaDetailsDTO?
        var error: String?
        let expectation = self.expectation(description: "\(api2Test).\(request) expectation timeout")
        factory.getMangas { data, errorMessage in
            guard let id = data?.first?.id else { return }
            self.factory.getMangaById(id: id) { data, errorMessage in
                response = data
                error = errorMessage
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 15)
        XCTAssertNil(error, "Unexpected \(api2Test).\(request) error \(error ?? "")")

        XCTAssertNotNil(response, "Unexpected \(api2Test).\(request) nil result")
    }
}
