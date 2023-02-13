//
//  String+htmlToString.swift
//  ShikiApp
//
//  Created by Сергей Черных on 01.02.2023.
//

import Foundation

extension String {

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
}
