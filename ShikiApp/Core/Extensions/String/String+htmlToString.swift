//
//  String+htmlToString.swift
//  ShikiApp
//
//  Created by Сергей Черных on 01.02.2023.
//

import Foundation

extension String {
    
    // TODO: - Удалить

    // MARK: - Properties
    
    var imageURLs: [String] {
        let pattern = "https://[\\w\\.]+/system/user_images/original/[\\d]+/[\\d]+\\.jpg"
        return makeStringsEqualRegexPattern(pattern)
    }
    
    var youtubePreviewURLs: [String] {
        let pattern = "//(img.youtube.com/vi/.*?)jpg"
        let results = makeSubstringsContainRegexPattern(pattern)
        return results.map { "https:\($0)" }
    }

    // MARK: - Functions
    
    func htmlToString() -> String {
        var htmlToAttributedString: NSAttributedString? {
            guard let data = data(using: .utf8) else { return nil }
            do {
                return try NSAttributedString(
                    data: data,
                    options: [
                        .documentType: NSAttributedString.DocumentType.html,
                        .characterEncoding: String.Encoding.utf8.rawValue
                    ],
                    documentAttributes: nil
                )
            } catch {
                return nil
            }
        }
        return htmlToAttributedString?.string ?? ""
    }

    // TODO: - Удалить
    // MARK: - Private functions
    
    private func makeStringsEqualRegexPattern(_ pattern: String) -> [String] {
        var array = [String]()
        let strings = components(separatedBy: "<")
        for string in strings {
            if let range = string.range(of: pattern, options: .regularExpression) {
                array.append(String(string[range]))
            }
        }
        return array
    }
    
    private func makeSubstringsContainRegexPattern(_ pattern: String) -> [String] {
        var array = [String]()
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: [])
            let results = regex.matches(in: self, range: NSRange(self.startIndex..., in: self))
            for result in results {
                if let range = Range(result.range, in: self) {
                    let extractedString = String(self[range])
                    array.append(extractedString)
                }
            }
            return array
        } catch {
            print("invalid regex: \(error.localizedDescription)")
        }
        return []
    }
}
