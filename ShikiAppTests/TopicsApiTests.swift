//
//  TopicsApiTests.swift
//  ShikiAppTests
//
//  Created by Алексей Шинкарев on 23.01.2023.
//

@testable import ShikiApp
import XCTest

final class TopicsApiTests: XCTestCase {

    private let api2Test = "TopicsRequestFactory"
    
    override func setUpWithError() throws {
        try? super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try? super.tearDownWithError()
    }
    
    func testListTopics() throws {
        
        let factory = ApiFactory.makeTopicsApi()
        let request = "listTopics"
        var response: TopicsResponseDTO?
        var error: String?
        let expectation = self.expectation(description: "\(api2Test).\(request) expectation timeout")
        
        factory.listTopics(
            page: 1,
            limit: 10,
            forum: .all,
            type: .topic
        ) { data, errorMessage in
            response = data
            error = errorMessage
            expectation.fulfill()
        }
        waitForExpectations(timeout: 15)
        XCTAssertNil(error, "Unexpected \(api2Test).\(request) error \(error ?? "")")
        XCTAssertFalse(response?.isEmpty ?? true, "Unexpected \(api2Test).\(request) empty or nil result")
    }

    func testHotTopics() throws {
        
        let factory = ApiFactory.makeTopicsApi()
        let request = "hotTopics"
        var response: TopicsResponseDTO?
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
        
        let factory = ApiFactory.makeTopicsApi()
        let request = "newTopics"
        var response: NewsTopicsResponseDTO?
        var error: String?
        let expectation = self.expectation(description: "\(api2Test).\(request) expectation timeout")
        
        factory.newTopics(
            page: 1,
            limit: 10
        ) { data, errorMessage in
            response = data
            error = errorMessage
            expectation.fulfill()
        }
        waitForExpectations(timeout: 15)
        XCTAssertNil(error, "Unexpected \(api2Test).\(request) error \(error ?? "")")
        XCTAssertFalse(response?.isEmpty ?? true, "Unexpected \(api2Test).\(request) empty or nil result")
    }

    func testGetTopic() throws {
        
        let factory = ApiFactory.makeTopicsApi()
        let request = "getTopic"
        let expectation = expectation(description: "\(api2Test)\(request) expectation timeout")
        var topic: TopicDTO?
        var error: String?
        
        factory.listTopics { data, errorMessage in
            if let id = data?.first?.id {
                factory.getTopic(id: id) { data, errorMessage in
                    topic = data
                    error = errorMessage
                    expectation.fulfill()
                }
            }
        }
        waitForExpectations(timeout: 15)
        XCTAssertNil(error, "Unexpected \(api2Test).\(request) error \(error ?? "")")
        XCTAssertNotNil(topic, "Unexpected \(api2Test).\(request) nil result")
    }

    func testAddTopic() throws {
        
        if !AuthManager.share.isAuth() { return }
        let factory = ApiFactory.makeTopicsApi()
        let request = "addTopic"
        var topic: TopicDTO?
        var error: String?
        let userFactory = ApiFactory.makeUsersApi()
        let forumFactory = ApiFactory.makeForumsApi()
        let expectation = expectation(description: "\(api2Test)\(request) expectation timeout")
        
        userFactory.whoAmI { data, errorMessage in
            guard let user = data else { return }
            forumFactory.listForums { data, errorMessage in
                guard let forum = data?.first else { return }
                let newTopic = NewTopicDTO(
                    body: "test body",
                    linkedType: nil,
                    title: "Test title",
                    type: "Topic",
                    forumID: forum.id,
                    linkedID: nil,
                    userID: user.id
                )
                factory.addTopic(topic: newTopic) { data, errorMessage in
                    topic = data
                    error = errorMessage
                    expectation.fulfill()
                }
            }
        }
        waitForExpectations(timeout: 15)
        XCTAssertNil(error, "Unexpected \(api2Test).\(request) error \(error ?? "")")
        XCTAssertNotNil(topic, "Unexpected \(api2Test).\(request) nil result")
        if let id = topic?.id {
            factory.deleteTopic(id: id) { _, errorMessage in
                XCTAssertNil(errorMessage, "Unexpected \(self.api2Test).\(request) error \(errorMessage ?? "") on delete topic \(id)")
            }
        }
    }
    
    func testDeleteTopic() throws {
        
        if !AuthManager.share.isAuth() { return }
        let factory = ApiFactory.makeTopicsApi()
        let request = "deleteTopic"
        var topic: DeleteTopicResponseDTO?
        var error: String?
        let userFactory = ApiFactory.makeUsersApi()
        let forumFactory = ApiFactory.makeForumsApi()
        let expectation = expectation(description: "\(api2Test)\(request) expectation timeout")
        
        userFactory.whoAmI { data, errorMessage in
            guard let user = data else { return }
            forumFactory.listForums { data, errorMessage in
                guard let forum = data?.first else { return }
                let newTopic = NewTopicDTO(
                    body: "test body",
                    linkedType: nil,
                    title: "Test title",
                    type: "Topic",
                    forumID: forum.id,
                    linkedID: nil,
                    userID: user.id
                )
                factory.addTopic(topic: newTopic) { data, errorMessage in
                    if let id = data?.id {
                        factory.deleteTopic(id: id) { data, errorMessage in
                            topic = data
                            error = errorMessage
                            expectation.fulfill()
                        }
                    }
                }
            }
        }
        waitForExpectations(timeout: 15)
        XCTAssertNil(error, "Unexpected \(api2Test).\(request) error \(error ?? "")")
        XCTAssertNotNil(topic, "Unexpected \(api2Test).\(request) nil result")
    }
    
    func testChangeTopic() throws {
        
        if !AuthManager.share.isAuth() { return }
        let factory = ApiFactory.makeTopicsApi()
        let request = "putTopic"
        var topic: TopicDTO?
        var error: String?
        let userFactory = ApiFactory.makeUsersApi()
        let forumFactory = ApiFactory.makeForumsApi()
        let expectation = expectation(description: "\(api2Test)\(request) expectation timeout")
        
        userFactory.whoAmI { data, errorMessage in
            guard let user = data else { return }
            forumFactory.listForums { data, errorMessage in
                guard let forum = data?.first else { return }
                let newTopic = NewTopicDTO(
                    body: "test body",
                    linkedType: nil,
                    title: "Test title",
                    type: "Topic",
                    forumID: forum.id,
                    linkedID: nil,
                    userID: user.id
                )
                factory.addTopic(topic: newTopic) { data, errorMessage in
                    if let id = data?.id {
                        factory.putTopic(
                            id: id,
                            title: "new Title",
                            body: "new Body",
                            linkedId: nil,
                            linkedType: nil
                        ) { data, errorMessage in
                            topic = data
                            error = errorMessage
                            expectation.fulfill()
                        }
                    }
                }
            }
        }
        waitForExpectations(timeout: 15)
        XCTAssertNil(error, "Unexpected \(api2Test).\(request) error \(error ?? "")")
        XCTAssertNotNil(topic, "Unexpected \(api2Test).\(request) nil result")
        if let id = topic?.id {
            factory.deleteTopic(id: id) { _, errorMessage in
                XCTAssertNil(error, "Unexpected \(self.api2Test).\(request) error \(errorMessage ?? "") on delete topic \(id)")
            }
        }
    }
}
