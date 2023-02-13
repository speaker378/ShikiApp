//
//  SearchFormatters.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 03.02.2023.
//

import UIKit

struct SearchFormatters {

    // MARK: - Private Properties
    
    private static var dateYearFormatter: DateFormatter = {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(identifier: "GMT")
        return formatter
    }()

    // MARK: - Functions
    
    static func extractYear(date: String?) -> String {
        
        guard let date,
              let date = dateYearFormatter.date(from: date) else { return "..." }
        return "\(Calendar.current.component(.year, from: date))"
    }
    
    static func extractYears(airedOn: String?, releasedOn: String?, kind: String?) -> String {
        
        let airedYear = Self.extractYear(date: airedOn)
        return Self.isSingleDateKind(kind: kind) ? airedYear : "\(airedYear) - \(Self.extractYear(date: releasedOn))"
    }
    
    static func extractUrlString(image: ImageDTO?) -> String {
        
        guard let image else { return "" }
        return "\(Constants.Url.baseUrl)\(image.preview)"
    }
    
    static func extractUIImage(image: ImageDTO?) -> UIImage {
        
        guard let image,
              let url = URL(string: image.preview),
              let imageData = try? Data(contentsOf: url),
              let image = UIImage(data: imageData) else { return UIImage() }
        return image
    }

    static func extractKind(kind: String?) -> String {
        
        guard let kind,
              let kindDescription = SearchConstants.kindsDictionary[kind]
        else { return "" }
        return kindDescription
    }
    
    static func isSingleDateKind(kind: String?) -> Bool {
        
        guard let kind else { return true}
        return SearchConstants.singleDateKinds.contains(kind)
    }
    
    static func extractScore(score: String?) -> String {
        
        guard let score,
              let floatScore = Float(score) else { return "" }
        return String(format: "%.1f", floatScore) 
    }
    
    static func extractScoreColor(score: String?) -> UIColor {
        SearchConstants.scoreColors[score?.first ?? " "] ?? AppColor.line
    }
}
