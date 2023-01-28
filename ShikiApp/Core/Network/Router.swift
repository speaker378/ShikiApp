//
//  Router.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 17.01.2023.
//

import Foundation

typealias NetworkRouterCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void

// MARK: - NetworkRouter protocol

protocol NetworkRouter {
    associatedtype EndPoint: EndPointType
    var token: String? { get }
    var userAgent: String? { get }
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
    func cancel()
}

final class Router<EndPoint: EndPointType>: NetworkRouter {

    // MARK: - Properties

    var token: String?
    var userAgent: String?

    // MARK: - Properties

    private let queue: OperationQueue
    private var task: URLSessionTask?

    // MARK: - Construction

    init(token: String?, userAgent: String?) {
        queue = OperationQueue()
        queue.qualityOfService = .utility
        self.token = token
        self.userAgent = userAgent
    }

    // MARK: - Functions

    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: queue)

        do {
            let request = try self.buildRequest(from: route)
            self.task = session.dataTask(with: request, completionHandler: { data, response, error in
                completion(data, response, error)
            })
        } catch {
            completion(nil, nil, error)
        }
        self.task?.resume()
    }

    func cancel() {
        self.task?.cancel()
    }

    // MARK: - Private functions

    private func buildRequest(from route: EndPoint) throws -> URLRequest {
        var request = URLRequest(
            url: EndPoint.baseURL.appendingPathComponent(route.path),
            cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
            timeoutInterval: 10.0
        )
        request.httpMethod = route.httpMethod.rawValue
        if let token = self.token {
            request.setValue("\(HttpConstants.bearer.rawValue) \(token)", forHTTPHeaderField: HttpConstants.authorization.rawValue)
        }
        if let userAgent = self.userAgent {
            request.setValue(userAgent, forHTTPHeaderField: HttpConstants.agent.rawValue)
        }
        do {
            switch route.task {
            case .request:
                request.setValue(
                    HttpConstants.jsonContent.rawValue,
                    forHTTPHeaderField: HttpConstants.contentType.rawValue
                )
            case .requestParameters(
                let bodyParameters,
                let bodyEncoding,
                let urlParameters
            ):
                
                try self.configureParameters(
                    bodyParameters: bodyParameters,
                    bodyEncoding: bodyEncoding,
                    urlParameters: urlParameters,
                    request: &request
                )
                
            case .requestParametersAndHeaders(
                let bodyParameters,
                let bodyEncoding,
                let urlParameters,
                let additionalHeaders
            ):
                
                self.addAdditionalHeaders(additionalHeaders, request: &request)
                try self.configureParameters(
                    bodyParameters: bodyParameters,
                    bodyEncoding: bodyEncoding,
                    urlParameters: urlParameters,
                    request: &request
                )
            }
            return request
        } catch {
            throw error
        }
    }

    private func configureParameters(bodyParameters: Parameters?, bodyEncoding: ParameterEncoding, urlParameters: Parameters?, request: inout URLRequest) throws {
        do {
            try bodyEncoding.encode(
                urlRequest: &request,
                bodyParameters: bodyParameters,
                urlParameters: urlParameters
            )
        } catch {
            throw error
        }
    }

    private func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
}
