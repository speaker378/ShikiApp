//
//  UserRates+CoreDataProperties.swift
//  ShikiApp
//
//  Created by Сергей Черных on 21.02.2023.
//
//

import CoreData


extension UserRates {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserRates> {
        return NSFetchRequest<UserRates>(entityName: "UserRates")
    }

    @NSManaged public var id: Int64
    @NSManaged public var score: Int16
    @NSManaged public var status: String?
    @NSManaged public var rewatches: Int64
    @NSManaged public var episodes: Int64
    @NSManaged public var volumes: Int64
    @NSManaged public var chapters: Int64
    @NSManaged public var createdAt: Date?
    @NSManaged public var updatedAt: Date?

}

extension UserRates: Identifiable {

}
