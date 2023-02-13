//
//  AbstractRequestFactory.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 17.01.2023.
//

import Foundation

// MARK: - Result

enum Result<String> {
    case success(String)
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

    // MARK: - Properties
    
    var router: Router<API>

    // MARK: - Constructions

    init(token: String? = nil, agent: String? = nil) {
        router = Router<API>(token: token, userAgent: agent)
    }

    // MARK: - Funcions

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
                    completion(nil, NetworkLayerErrorMessages.badResponse)
                }
                return
            }
            let result = self.handleNetworkResponse(response)
            switch result {
            case .success:
                let decodedResult = self.decodeData(type: type, data: data)
                DispatchQueue.main.async {
                    completion(decodedResult.0, decodedResult.1)
                }
            case let .failure(networkError):
                DispatchQueue.main.async {
                    completion(nil, networkError)
                }
            }
        }
    }

    // MARK: - Private Functions
    
    private func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200 ... 299: return .success("success")
        case 401 ... 500: return .failure(NetworkLayerErrorMessages.authenticationError)
        case 501 ... 599: return .failure(NetworkLayerErrorMessages.badRequest)
        case 600: return .failure(NetworkLayerErrorMessages.outdated)
        default: return .failure(NetworkLayerErrorMessages.requestFailed)
        }
    }

    private func decodeData<Response: Codable>(type: Response.Type, data: Data?) -> (Response?, String?) {
        guard let data = data else { return (nil, NetworkLayerErrorMessages.noData) }
        switch type.self {
        case is String.Type:
            guard let data = String(data: data, encoding: .utf8) as? Response else {
                return (nil, NetworkLayerErrorMessages.unableToDecode)
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
