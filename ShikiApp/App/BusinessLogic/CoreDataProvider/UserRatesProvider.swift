//
//  UserRatesProvider.swift
//  ShikiApp
//
//  Created by Сергей Черных on 21.02.2023.
//

import CoreData

final class UserRatesProvider {

    // MARK: - Properties

    lazy var controller: NSFetchedResultsController<UserRates> = {
        let fetchRequest: NSFetchRequest<UserRates> = UserRates.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: #keyPath(UserRates.score), ascending: false)]

        let controller = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        controller.delegate = delegate

        do {
            try controller.performFetch()
        } catch {
            assertionFailure("Fetch failed")
        }

        return controller
    }()

    // MARK: - Private properties

    private(set) var context: NSManagedObjectContext
    private weak var delegate: NSFetchedResultsControllerDelegate?

    // MARK: - Construction

    init(with context: NSManagedObjectContext, delegate: NSFetchedResultsControllerDelegate? = nil) {
        self.context = context
        self.delegate = delegate
    }
}
