//
//  TopicsApi.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 19.01.2023.
//

import Foundation

enum TopicsApi {
    case listTopics(parameters: Parameters)
    case newTopics(parameters: Parameters)
    case hotTopics(parameters: Parameters)
    case getTopic(id: Int)
    case postTopic(parameters: Parameters)
    case putTopic(id: Int, parameters: Parameters)
    case deleteTopic(id: Int)
}

extension TopicsApi: EndPointType {
    var path: String {
        switch self {
        case .listTopics, .postTopic:
            return "topics"
        case .newTopics:
            return "topics/updates"
        case .hotTopics:
            return "topics/hot"
        case .putTopic(let id, _):
            return "topics/\(id)"
        case .getTopic(let id), .deleteTopic(let id):
            return "topics/\(id)"
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .listTopics, .newTopics, .hotTopics, .getTopic:
            return .get
        case .postTopic:
            return .post
        case .putTopic:
            return .patch
        case .deleteTopic:
            return .delete
        }
    }

    var task: HTTPTask {
        switch self {
        case .listTopics(let parameters),
             .newTopics(let parameters),
             .hotTopics(let parameters):
            return .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: parameters)
        case .getTopic,
             .deleteTopic:
            return .request
        case .postTopic(let parameters),
             .putTopic(_, let parameters):
            return .requestParameters(bodyParameters: parameters, bodyEncoding: .jsonEncoding, urlParameters: nil)
        }
    }

    var headers: HTTPHeaders? { nil }
}
