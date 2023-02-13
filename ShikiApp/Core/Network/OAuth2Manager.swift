//
//  OAuth2Manager.swift
//  ShikiApp
//
//  Created by Сергей Черных on 08.02.2023.
//

import AuthenticationServices

final class OAuth2Manager: NSObject {

    // MARK: - Private properties

    private var credential: OAuth2Credential?

    // MARK: - Functions
    
    func auth(with request: OAuth2Request, completion: @escaping (OAuth2Credential?) -> Void) {
        guard let components = URLComponents(string: request.redirectUri),
              let callbackScheme = components.scheme,
              let requestUrl = request.makeAuthURL()
        else { return }
        
        self.requestAuth(with: requestUrl, scheme: callbackScheme) { result in
            switch result {
            case .failure:
                return
            case .success(let code):
                guard let tokenUrl = request.makeTokenURL(code: code) else { return }
                self.requestToken(for: tokenUrl) { credential in
                   completion(credential)
                }
            }
        }
    }
    
    func requestToken(for url: URL, completion: @escaping (OAuth2Credential?) -> Void) {
        var request =  URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let queue = OperationQueue()
        queue.qualityOfService = .utility
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: queue)
        
        let task = session.dataTask(with: request) { data, response, _  in
            guard let httpResponse = response as? HTTPURLResponse,
                  200..<300 ~= httpResponse.statusCode,
                  let data = data
            else { return }
            completion(try? decoder.decode(OAuth2Credential.self, from: data))
        }
        task.resume()
    }

    // MARK: - Private functions
    
    private func requestAuth(with url: URL?, scheme: String, completion: @escaping (Result<String>) -> Void) {
        guard let url = url else { return }
        let session = ASWebAuthenticationSession(url: url, callbackURLScheme: scheme) { callbackURL, error in
            if let error = error {
                completion(.failure(error.localizedDescription))
                return
            }
            guard let url = callbackURL else { return }
            if let token = URLComponents(string: url.absoluteString)?
                .queryItems?.first(where: { $0.name == "code" })?.value {
                completion(.success(token))
            } else {
                completion(.failure("tokenNotFound"))
            }
        }
        session.prefersEphemeralWebBrowserSession = true
        session.presentationContextProvider = self
        session.start()
    }
}

extension OAuth2Manager: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return ASPresentationAnchor()
    }
}
