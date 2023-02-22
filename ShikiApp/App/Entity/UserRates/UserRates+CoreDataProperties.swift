//
//  UserRates+CoreDataProperties.swift
//  ShikiApp
//
//  Created by Сергей Черных on 21.02.2023.
//
//

import CoreData


extension UserRates {

    @nonobjc static func fetchRequest() -> NSFetchRequest<UserRates> {
        return NSFetchRequest<UserRates>(entityName: "UserRates")
    }

    @NSManaged var id: Int64
    @NSManaged var score: Int16
    @NSManaged var status: String?
    @NSManaged var rewatches: Int64
    @NSManaged var episodes: Int64
    @NSManaged var volumes: Int64
    @NSManaged var chapters: Int64
    @NSManaged var createdAt: Date?
    @NSManaged var updatedAt: Date?

}

extension UserRates: Identifiable {

}
