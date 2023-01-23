//
//  TopicsRequestFactory.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 19.01.2023.
//

import Foundation

final class TopicsRequestFactory: AbstractRequestFactory<TopicsApi> {
    func listTopics(page: Int? = nil, limit: Int? = nil, forum: ForumParameter? = nil, linkedId: Int? = nil, linkedType: LinkedTypeParameter? = nil, type: TopicTypeParameter? = nil, completion: @escaping (_ response: TopicsResponse?, _ error: String?) -> Void) {
        var parameters = Parameters()
        if let page = page, (1 ... 100_000).contains(page) { parameters["page"] = page }
        if let limit = limit, (1 ... 30).contains(limit) { parameters["limit"] = limit }
        if let forum = forum { parameters["forum"] = forum.rawValue }
        if let linkedId = linkedId { parameters["linked_id"] = linkedId }
        if let linkedType = linkedType { parameters["linked_type"] = linkedType.rawValue }
        if let type = type { parameters["type"] = type.rawValue }
        getResponse(type: TopicsResponse.self, endPoint: .listTopics(parameters: parameters), completion: completion)
    }

    func newTopics(page: Int? = nil,
                   limit: Int? = nil,
                   completion: @escaping (_ response: NewsTopicsResponse?, _ error: String?) -> Void) {
        var parameters = Parameters()
        if let page = page, (1 ... 100_000).contains(page) { parameters["page"] = page }
        if let limit = limit, (1 ... 30).contains(limit) { parameters["limit"] = limit }
        getResponse(type: NewsTopicsResponse.self, endPoint: .newTopics(parameters: parameters), completion: completion)
    }

    func hotTopics(limit: Int?,
                   completion: @escaping (_ response: TopicsResponse?, _ error: String?) -> Void) {
        var parameters = Parameters()
        if let limit = limit, (1 ... 10).contains(limit) { parameters["limit"] = limit }
        getResponse(type: TopicsResponse.self, endPoint: .hotTopics(parameters: parameters), completion: completion)
    }

    func getTopic(id: Int, completion: @escaping (_ response: Topic?, _ error: String?) -> Void) {
        getResponse(type: Topic.self, endPoint: .getTopic(id: id), completion: completion)
    }

    func deleteTopic(id: Int, completion: @escaping (_ response: Topic?, _ error: String?) -> Void) {
        getResponse(type: Topic.self, endPoint: .deleteTopic(id: id), completion: completion)
    }

    func addTopic(topic: NewTopic, completion: @escaping (_ response: Topic?, _ error: String?) -> Void) {
        if "Topic".elementsEqual(topic.type),
           LinkedTypeParameter.allCases.map({ $0.rawValue }).contains(topic.linkedType) {
            var parameters = Parameters()
            parameters["topic"] = Mirror(reflecting: topic).children.map { $0 }.reduce(into: [:]) { $0[$1.label] = String(describing: $1.value) }
            getResponse(type: Topic.self, endPoint: .postTopic(parameters: parameters), completion: completion)
        } else {
            completionQueue.async {
                completion(nil, "Invalid topic to add")
            }
        }
    }

    func putTopic(id: Int, title: String?, body: String?, linkedId: Int?, linkedType: LinkedTypeParameter?, completion: @escaping (_ response: Topic?, _ error: String?) -> Void) {
        var changedFields = Parameters()
        if let title = title { changedFields["title"] = title }
        if let body = body { changedFields["body"] = body }
        if let linkedId = linkedId,
           let linkedType = linkedType {
            changedFields["linked_id"] = linkedId
            changedFields["linked_type"] = linkedType.rawValue
        }
        if !changedFields.isEmpty {
            var parameters = Parameters()
            parameters["topic"] = changedFields
            getResponse(type: Topic.self, endPoint: .putTopic(id: id, parameters: parameters), completion: completion)
        } else {
            completionQueue.async {
                completion(nil, "Invalid or empty attributes to change")
            }
        }
    }
}
