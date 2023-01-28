//
//  AbstractRequestFactory.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 17.01.2023.
//

import Foundation

// MARK: - Result

enum Result<String> {
    case success
    case failure(String)
}

// MARK: - AbstractRequestFactoryProtocol

protocol AbstractRequestFactoryProtocol {
    associatedtype API: EndPointType
    var router: Router<API> { get }
    func getResponse<Response: Codable>(type: Response.Type, endPoint: API, completion: @escaping (_ response: Response?, _ error: String?) -> Void)
}

// MARK: - AbstractRequestFactory

class AbstractRequestFactory<API: EndPointType>: AbstractRequestFactoryProtocol {
    internal var router: Router<API>

    init(token: String? = nil, agent: String? = nil) {
        router = Router<API>(token: token, userAgent: agent)
    }
    
    func getResponse<Response: Codable>(
        type: Response.Type,
        endPoint: API,
        completion: @escaping (_ response: Response?, _ error: String?) -> Void
    ) {
        router.request(endPoint) { data, response, error in
            if let error {
                DispatchQueue.main.async {
                    completion(nil, error.localizedDescription)
                }
                return
            }
            guard let response = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    completion(nil, NetworkResponse.badResponse.rawValue)
                }
                return
            }
            let result = handleNetworkResponse(response)
            switch result {
            case .success:
                let decodedResult = decodeData(data: data)
                DispatchQueue.main.async {
                    completion(decodedResult.0, decodedResult.1)
                }
            case let .failure(networkError):
                DispatchQueue.main.async {
                    completion(nil, networkError)
                }
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

        func decodeData(data: Data?) -> (Response?, String?) {
            guard let data = data else { return (nil, NetworkResponse.noData.rawValue) }
            switch type.self {
            case is String.Type:
                guard let data = String(data: data, encoding: .utf8) as? Response else {
                    return (nil, NetworkResponse.unableToDecode.rawValue)
                }
                return (data, nil)
            default:
                do {
                    let data = try JSONDecoder().decode(Response.self, from: data)
                    return (data, nil)
                } catch {
                    return (nil, error.localizedDescription)
                }
            }
        }
    }
}
