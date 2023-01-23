//
//  AbstractRequestFactory.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 17.01.2023.
//

import Foundation

// MARK: - NetworkResponse

enum NetworkResponse: String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
    case badResponse = "Bad response"
}

// MARK: - Result

enum Result<String> {
    case success
    case failure(String)
}

// MARK: - AbstractRequestFactoryProtocol

protocol AbstractRequestFactoryProtocol {
    associatedtype API: EndPointType
    var requestQueue: DispatchQueue { get }
    var completionQueue: DispatchQueue { get }
    var router: Router<API> { get }
}

// MARK: - AbstractRequestFactory

class AbstractRequestFactory<API: EndPointType>: AbstractRequestFactoryProtocol {
    internal var router: Router<API>
    internal var requestQueue = DispatchQueue.global(qos: .utility)
    internal var completionQueue = DispatchQueue.main

    init(token: String? = nil, agent: String? = nil) {
        router = Router<API>(token: token, userAgent: agent)
    }

    internal func getResponse<RESPONSE: Codable>(type: RESPONSE.Type, endPoint: API, completion: @escaping (_ response: RESPONSE?, _ error: String?) -> Void) {
        requestQueue.async { [weak self] in
            self?.router.request(endPoint) { data, response, error in
                if let error = error {
                    self?.completionQueue.async {
                        completion(nil, error.localizedDescription)
                    }
                    return
                }
                if let response = response as? HTTPURLResponse {
                    let result = handleNetworkResponse(response)
                    switch result {
                    case .success:
                        let decodedResult = decodeData(data: data)
                        self?.completionQueue.async {
                            completion(decodedResult.0, decodedResult.1)
                        }
                    case let .failure(networkError):
                        self?.completionQueue.async {
                            completion(nil, networkError)
                        }
                    }
                    return
                }
                self?.completionQueue.async {
                    completion(nil, NetworkResponse.badResponse.rawValue)
                }
            }

            func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
                switch response.statusCode {
                case 200 ... 299: return .success
                case 401 ... 500: return .failure(NetworkResponse.authenticationError.rawValue)
                case 501 ... 599: return .failure(NetworkResponse.badRequest.rawValue)
                case 600: return .failure(NetworkResponse.outdated.rawValue)
                default: return .failure(NetworkResponse.failed.rawValue)
                }
            }

            func decodeData(data: Data?) -> (RESPONSE?, String?) {
                guard let data = data else { return (nil, NetworkResponse.noData.rawValue) }
                switch type.self {
                case is String.Type:
                    guard let data = String(data: data, encoding: .utf8) as? RESPONSE else {
                        return (nil, NetworkResponse.unableToDecode.rawValue)
                    }
                    return (data, nil)
                default:
                    do {
                        let data = try JSONDecoder().decode(RESPONSE.self, from: data)
                        return (data, nil)
                    } catch let error {
                        print(error)
                        return (nil, NetworkResponse.unableToDecode.rawValue)
                    }
                }
            }
        }
    }
}
