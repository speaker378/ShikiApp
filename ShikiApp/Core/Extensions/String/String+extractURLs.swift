//
//  String+extractURLs.swift
//  ShikiApp
//
//  Created by Сергей Черных on 05.02.2023.
//

import Foundation

extension String {
    func extractURLs() -> [String] {
        var urls: [String] = []
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
            detector.enumerateMatches(
                in: self,
                options: [],
                range: NSRange(location: 0, length: self.count),
                using: { (result, _, _) in
                    if let match = result, let url = match.url {
                        urls.append(url.absoluteString)
                    }
                }
            )
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return urls
    }
}
