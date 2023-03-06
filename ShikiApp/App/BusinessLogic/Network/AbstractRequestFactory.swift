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

    init() {
        router = Router<API>()
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
                    completion(nil, Texts.NetworkLayerErrorMessages.badResponse)
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

    // MARK: - Private functions
    
    private func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        let responseCode = "\(response.statusCode) "
        switch response.statusCode {
        case 200 ... 299: return .success(Texts.NetworkLayerErrorMessages.success)
        case 300 ... 399: return .failure(responseCode +  Texts.NetworkLayerErrorMessages.redirect)
        case 401: return .failure(responseCode + Texts.NetworkLayerErrorMessages.authenticationError)
        case 403: return .failure(responseCode + Texts.NetworkLayerErrorMessages.accessDenied)
        case 429: return .failure(responseCode + Texts.NetworkLayerErrorMessages.tooManyRequests)
        case 400 ... 499: return .failure(responseCode + Texts.NetworkLayerErrorMessages.clientError)
        case 500 ... 599: return .failure(responseCode + Texts.NetworkLayerErrorMessages.serverError)
        case 600: return .failure(responseCode + Texts.NetworkLayerErrorMessages.outdated)
        default: return .failure(responseCode + Texts.NetworkLayerErrorMessages.requestFailed)
        }
    }

    private func decodeData<Response: Codable>(type: Response.Type, data: Data?) -> (Response?, String?) {
        guard let data = data else { return (nil, Texts.NetworkLayerErrorMessages.noData) }
        switch type.self {
        case is String.Type:
            guard let data = String(data: data, encoding: .utf8) as? Response else {
                return (nil, Texts.NetworkLayerErrorMessages.unableToDecode)
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
