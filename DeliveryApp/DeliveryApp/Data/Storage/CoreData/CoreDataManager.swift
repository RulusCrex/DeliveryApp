// CoreDataManager.swift
// HomeWorkTestApp

import CoreData
import UIKit

/// responsible for interaction with the CoreDat
protocol CoreDataManager {
    /// load object from core data
    /// - Parameter objectType: any NSManagedObject
    /// - Returns: any NSManagedObject
    func loadData<T: NSManagedObject>(_ objectType: T.Type) throws -> [T]
    /// delete object to core data
    /// - Parameter data: any NSManagedObject
    func deleteData<T: NSManagedObject>(_ data: T) throws
    /// saves object to core data
    /// - Parameter data: any NSManagedObject
    func saveData<T: NSManagedObject>(_ data: T) throws
    /// get context
    /// - Returns: current context
    func getContext() -> NSManagedObjectContext
}

final class CoreDataManagerImpl: NSObject, CoreDataManager {
    // MARK: Private Properties

    private var context: NSManagedObjectContext {
        appDelegate.persistenceContainer.viewContext
    }

    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as? AppDelegate ?? AppDelegate()
    }

    // MARK: Public Methods

    func getContext() -> NSManagedObjectContext {
        context
    }

    func loadData<T: NSManagedObject>(_ objectType: T.Type) throws -> [T] {
        let request = NSFetchRequest<T>(entityName: String(describing: objectType))
        return try context.fetch(request)
    }

    func deleteData<T: NSManagedObject>(_ data: T) throws {
        context.delete(data)
        try context.save()
    }

    func saveData<T: NSManagedObject>(_ data: T) throws {
        guard context.hasChanges else { return }
        try context.save()
    }
}
