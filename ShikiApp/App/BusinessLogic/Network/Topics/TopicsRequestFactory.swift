//
//  TopicsRequestFactory.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 19.01.2023.
//

import Foundation

// MARK: - TopicsRequestFactoryProtocol

protocol TopicsRequestFactoryProtocol {

    // MARK: - Properties
    
    var delegate: (AbstractRequestFactory<TopicsApi>)? { get }

    // MARK: - Functions
    
    func listTopics(page: Int?, limit: Int?, forum: ForumParameter?, linkedId: Int?, linkedType: LinkedTypeParameter?, type: TopicTypeParameter?, completion: @escaping (_ response: TopicsResponseDTO?, _ error: String?) -> Void)

    func newTopics(page: Int?,
                   limit: Int?,
                   completion: @escaping (_ response: NewsTopicsResponseDTO?, _ error: String?) -> Void)

    func hotTopics(limit: Int?, completion: @escaping (_ response: TopicsResponseDTO?, _ error: String?) -> Void)

    func getTopic(id: Int, completion: @escaping (_ response: TopicDTO?, _ error: String?) -> Void)

    func deleteTopic(id: Int, completion: @escaping (_ response: DeleteTopicResponseDTO?, _ error: String?) -> Void)

    func addTopic(topic: NewTopicDTO, completion: @escaping (_ response: TopicDTO?, _ error: String?) -> Void)

    func putTopic(id: Int, title: String?, body: String?, linkedId: Int?, linkedType: LinkedTypeParameter?, completion: @escaping (_ response: TopicDTO?, _ error: String?) -> Void)
}

// MARK: TopicsRequestFactoryProtocol extension

extension TopicsRequestFactoryProtocol {

    // MARK: - Functions
    
    func listTopics(page: Int? = nil,
                    limit: Int? = nil,
                    forum: ForumParameter? = nil,
                    linkedId: Int? = nil,
                    linkedType: LinkedTypeParameter? = nil,
                    type: TopicTypeParameter? = nil,
                    completion: @escaping (_ response: TopicsResponseDTO?, _ error: String?) -> Void) {
        let parameters = validateParameters(
            page: page,
            limit: limit,
            forum: forum,
            linkedId: linkedId,
            linkedType: linkedType,
            type: type
        )
        delegate?.getResponse(
            type: TopicsResponseDTO.self,
            endPoint: TopicsApi.listTopics(parameters: parameters),
            completion: completion
        )
        return

    func validateParameters(page: Int?,
                            limit: Int?,
                            forum: ForumParameter?,
                            linkedId: Int?,
                            linkedType: LinkedTypeParameter?,
                            type: TopicTypeParameter?) -> Parameters {
            var parameters = Parameters()
            if let page = page, (1 ... APIRestrictions.maxPages.rawValue).contains(page) {
                parameters[APIKeys.page.rawValue] = page
            }
            if let limit = limit, (1 ... APIRestrictions.limit30.rawValue).contains(limit) {
                parameters[APIKeys.limit.rawValue] = limit
            }
            if let forum = forum {
                parameters[APIKeys.forum.rawValue] = forum.rawValue
            }
            if let linkedId = linkedId {
                parameters[APIKeys.linkedId.rawValue] = linkedId
            }
            if let linkedType = linkedType {
                parameters[APIKeys.linkedType.rawValue] = linkedType.rawValue
            }
            if let type = type {
                parameters[APIKeys.type.rawValue] = type.rawValue
            }
            return parameters
        }
    }

    func newTopics(page: Int? = nil,
                   limit: Int? = nil,
                   completion: @escaping (_ response: NewsTopicsResponseDTO?, _ error: String?) -> Void) {
        var parameters = Parameters()
        if let page = page,
           (1 ... APIRestrictions.maxPages.rawValue).contains(page) {
            parameters[APIKeys.page.rawValue] = page
        }
        if let limit = limit,
           (1 ... APIRestrictions.limit30.rawValue).contains(limit) {
            parameters[APIKeys.limit.rawValue] = limit
        }
        delegate?.getResponse(
            type: NewsTopicsResponseDTO.self,
            endPoint: .newTopics(parameters: parameters),
            completion: completion
        )
    }

    func hotTopics(limit: Int?,
                   completion: @escaping (_ response: TopicsResponseDTO?, _ error: String?) -> Void) {
        var parameters = Parameters()
        if let limit = limit,
           (1 ... APIRestrictions.limit10.rawValue).contains(limit) {
            parameters[APIKeys.limit.rawValue] = limit
        }
        delegate?.getResponse(
            type: TopicsResponseDTO.self,
            endPoint: .hotTopics(parameters: parameters),
            completion: completion
        )
    }

    func getTopic(id: Int, completion: @escaping (_ response: TopicDTO?, _ error: String?) -> Void) {
        delegate?.getResponse(type: TopicDTO.self, endPoint: .getTopic(id: id), completion: completion)
    }

    func deleteTopic(id: Int,
                     completion: @escaping (_ response: DeleteTopicResponseDTO?, _ error: String?) -> Void) {
        delegate?.getResponse(
            type: DeleteTopicResponseDTO.self,
            endPoint: .deleteTopic(id: id),
            completion: completion
        )
    }

    func addTopic(topic: NewTopicDTO,
                  completion: @escaping (_ response: TopicDTO?, _ error: String?) -> Void) {
        if let topicDictionary = validateParameters(topic: topic) {
            var parameters = Parameters()
            parameters[APIKeys.topic.rawValue] = topicDictionary
            delegate?.getResponse(
                type: TopicDTO.self,
                endPoint: .postTopic(parameters: parameters),
                completion: completion
            )
        } else {
            completion(nil, "Invalid topic to add")
        }
        return

        func validateParameters(topic: NewTopicDTO) -> Parameters? {
            var parameters = Parameters()
            guard let body = topic.body,
                  let title = topic.title,
                  let forumId = topic.forumID else { return nil }
            if let linkedId = topic.linkedID,
               let linkedType = topic.linkedType {
                if !LinkedTypeParameter.allCases.map({ $0.rawValue }).contains(linkedType) { return nil }
                parameters[APIKeys.linkedId.rawValue] = String(describing: linkedId)
                parameters[APIKeys.linkedType.rawValue] = linkedType
            }
            parameters[APIKeys.userId.rawValue] = String(describing: topic.userID)
            parameters[APIKeys.body.rawValue] = body
            parameters[APIKeys.forumId.rawValue] = String(describing: forumId)
            parameters[APIKeys.type.rawValue] = TopicTypeParameter.topic.rawValue
            parameters[APIKeys.title.rawValue] = title
            return parameters
        }
    }

    func putTopic(id: Int,
                  title: String?,
                  body: String?,
                  linkedId: Int?,
                  linkedType: LinkedTypeParameter?,
                  completion: @escaping (_ response: TopicDTO?, _ error: String?) -> Void) {
        if let fieldsToChange = validateParameters(
            title: title,
            body: body,
            linkedId: linkedId,
            linkedType: linkedType
        ) {
            var parameters = Parameters()
            parameters[APIKeys.topic.rawValue] = fieldsToChange
            delegate?.getResponse(
                type: TopicDTO.self,
                endPoint: .putTopic(id: id, parameters: parameters),
                completion: completion
            )
        } else {
                completion(nil, "Nothing to change")
        }
        return

        func validateParameters(title: String?,
                                body: String?,
                                linkedId: Int?,
                                linkedType: LinkedTypeParameter?) -> Parameters? {
            var parameters = Parameters()
            var result: Parameters?
            if let title = title { parameters[APIKeys.title.rawValue] = title }
            if let body = body { parameters[APIKeys.body.rawValue] = body }
            if let linkedId = linkedId,
               let linkedType = linkedType {
                parameters[APIKeys.linkedId.rawValue] = linkedId
                parameters[APIKeys.linkedType.rawValue] = linkedType.rawValue
            }
            if !parameters.isEmpty { result = parameters }
            return result
        }
    }
}

// MARK: - TopicsRequestFactory

final class TopicsRequestFactory: TopicsRequestFactoryProtocol {

    // MARK: - Properties
    
    let delegate: (AbstractRequestFactory<TopicsApi>)?

    // MARK: - Construction
    
    init(token: String? = nil, agent: String? = nil) {
        self.delegate = AbstractRequestFactory<TopicsApi>(token: token, agent: agent)
    }
}
