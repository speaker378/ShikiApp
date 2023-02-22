//
//  CoreDataStack.swift
//  ShikiApp
//
//  Created by Сергей Черных on 21.02.2023.
//

import CoreData

final class CoreDataStack {

    // MARK: - Properties

    lazy var managedContext: NSManagedObjectContext = self.storeContainer.viewContext

    // MARK: - Private properties

    private let modelName: String
    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores { _, error in
            if let error {
                assertionFailure("Unresolved error \(error)")
            }
        }
        return container
    }()

    // MARK: - Construction

    init(modelName: String) {
        self.modelName = modelName
    }

    // MARK: - Functions

    func saveContext() {
        guard managedContext.hasChanges else { return }
        do {
            try managedContext.save()
        } catch let error {
            assertionFailure("Unresolved error \(error)")
        }
    }
}
