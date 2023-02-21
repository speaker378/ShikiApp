//
//  MyListViewController.swift
//  ShikiApp
//
//  Created by Константин Шмондрик on 21.01.2023.
//

import UIKit
import CoreData

class MyListViewController: UIViewController {
    
    private let apiFactory = ApiFactory.makeUserRatesApi()
    private lazy var coreDataStack = { CoreDataStack(modelName: "UserRates") }()
    private lazy var dataProvider = UserRatesProvider(with: coreDataStack.managedContext)
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    func getData() { // TODO: для примера
        apiFactory.list() { response in
            for item in response {
                UserRates.createOrUpdate(item: item, with: self.coreDataStack)
            }
            self.coreDataStack.saveContext()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerCell(CELL.self) // TODO: будущая ячейка
//        self.view.backgroundColor = AppColor.backgroundMain
    }
}

extension MyListViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }

    func controller(
        _ controller: NSFetchedResultsController<NSFetchRequestResult>,
        didChange sectionInfo: NSFetchedResultsSectionInfo,
        atSectionIndex sectionIndex: Int,
        for type: NSFetchedResultsChangeType
    ) {
        switch type {
        case .insert:
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .none)
        case .delete:
            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .none)
        default:
            break
        }
    }

    func controller(
        _ controller: NSFetchedResultsController<NSFetchRequestResult>,
        didChange anObject: Any,
        at indexPath: IndexPath?,
        for type: NSFetchedResultsChangeType,
        newIndexPath: IndexPath?
    ) {
        guard let newIndexPath,
              let indexPath
        else { return }
        
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath], with: .none)
        case .delete:
            tableView.deleteRows(at: [indexPath], with: .none)
        case .move:
            tableView.deleteRows(at: [indexPath], with: .none)
            tableView.insertRows(at: [newIndexPath], with: .none)
        case .update:
            let cell = tableView.cell(forRowAt: indexPath) ?? UITableViewCell()
            let item = dataProvider.controller.object(at: indexPath)
            cell.configure(witch: item)
        default:
            break
        }
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}
