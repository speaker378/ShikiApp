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

    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
    func cancel()
}

final class Router<EndPoint: EndPointType>: NetworkRouter {

    // MARK: - Private properties

    private let queue: OperationQueue
    private var task: URLSessionTask?
    private let userAgent: String?
    private let authManager: AuthManagerProtocol

    // MARK: - Construction

    init() {
        queue = OperationQueue()
        queue.qualityOfService = .utility
        userAgent = Bundle.main.infoDictionary?["CFBundleName"] as? String
        authManager = AuthManager.share
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
        if let token = authManager.getToken() {
            request.setValue("\(HttpConstants.bearer) \(token)", forHTTPHeaderField: HttpConstants.authorization)
        }
        if let userAgent = self.userAgent {
            request.setValue(userAgent, forHTTPHeaderField: HttpConstants.agent)
        }
        do {
            switch route.task {
            case .request:
                request.setValue(
                    HttpConstants.jsonContent,
                    forHTTPHeaderField: HttpConstants.contentType
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
