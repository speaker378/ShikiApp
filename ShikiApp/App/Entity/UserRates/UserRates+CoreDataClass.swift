//
//  UserRates+CoreDataClass.swift
//  ShikiApp
//
//  Created by Сергей Черных on 21.02.2023.
//
//

import CoreData

@objc(UserRates)
class UserRates: NSManagedObject {
    
    static func createOrUpdate(item: AnimeRateDTO, with stack: CoreDataStack) {
        var currentUserRate: UserRates?
        let newsPostFetch: NSFetchRequest<UserRates> = UserRates.fetchRequest()
        let newsItemIDPredicate = NSPredicate(format: "id == %i", item.id)
        newsPostFetch.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [newsItemIDPredicate])
        
        do {
            let results = try stack.managedContext.fetch(newsPostFetch)
            if results.isEmpty {
                currentUserRate = UserRates(context: stack.managedContext)
                currentUserRate?.id = Int64(item.id)
            } else {
                currentUserRate = results.first
            }
            currentUserRate?.update(item: item)
        } catch let error {
            assertionFailure("Fetch error: \(error)")
        }
    }

    private func update(item: AnimeRateDTO) {
        self.id = Int64(item.id)
        self.score = Int16(item.score)
        self.status = item.status
        self.rewatches = Int64(item.rewatches ?? 0)
        self.episodes = Int64(item.episodes)
        self.volumes = Int64(item.volumes ?? 0)
        self.chapters = Int64(item.chapters ?? 0)
        self.createdAt = item.createdAt?.convertToDate()
        self.updatedAt = item.updatedAt?.convertToDate()
    }
}
