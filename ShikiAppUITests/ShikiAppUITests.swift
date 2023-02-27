//
//  ShikiAppUITests.swift
//  ShikiAppUITests
//
//  Created by Сергей Черных on 15.01.2023.
//

import XCTest

final class ShikiAppUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
        try? super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try? super.tearDownWithError()
    }

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
