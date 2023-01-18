//
//  ForumsRequestFactory.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 17.01.2023.
//

import Foundation

final class ForumsRequestFactory: AbstractRequestFactory {
    typealias EPTYPE = ForumsApi
    internal let router: Router<ForumsApi>

    init(token: String?, agent: String?) {
        self.router = Router<ForumsApi>(token: token, userAgent: agent)
    }

    public func getForums(completion: @escaping (_ forumList: ForumsResponse?, _ error: String?) -> Void) {
        requestQueue.async { [weak self] in
            self?.router.request(.list) { data, response, error in
                if let error = error {
                    self?.completionQueue.async {
                        completion(nil, error.localizedDescription)
                    }
                }
                if let response = response as? HTTPURLResponse {
                    let result = self?.handleNetworkResponse(response)
                    switch result {
                    case .success:
                        guard let data = data else {
                            self?.completionQueue.async {
                                completion(nil, NetworkResponse.noData.rawValue)
                            }
                            return
                        }
                        do {
                            let data = try JSONDecoder().decode(ForumsResponse.self, from: data)
                            self?.completionQueue.async {
                                completion(data, nil)
                            }
                        } catch {
                            self?.completionQueue.async {
                                completion(nil, NetworkResponse.unableToDecode.rawValue)
                            }
                        }
                    case .failure(let networkError):
                        self?.completionQueue.async {
                            completion(nil, networkError)
                        }
                    case .none:
                        self?.completionQueue.async {
                            completion(nil, NetworkResponse.failed.rawValue)
                        }
                    }
                }
            }
        }
    }
}
