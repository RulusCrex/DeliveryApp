// StoragesRepository.swift
// HomeWorkTestApp

import CoreData
import RealmSwift

protocol StoragesRepository {
    /// configure
    /// - Parameters:
    ///   - realmManager: realm manage
    ///   - coreDataManager: coreDataManager
    func configure(realmManager: RealmManager, coreDataManager: CoreDataManager)
    /// save to Realm
    /// - Parameter data: any Object
    func saveToRealm<T: Object>(_ data: T)
    /// load to Realm
    /// - Returns: any Object
    func loadToRealm<T: Object>() -> [T]
    /// delete to Realm
    /// - Parameter data: any Object
    func deleteToRealm<T: Object>(_ data: T)
    /// saveToCoreData
    /// - Parameter data: any NSManagedObject
    func saveToCoreData<T: NSManagedObject>(_ data: T) throws
    /// loadToCoreData
    /// - Parameter objectType: any NSManagedObject
    /// - Returns: any NSManagedObject
    func loadToCoreData<T: NSManagedObject>(_ objectType: T.Type) throws -> [T]
    /// deleteToCoreData
    /// - Parameter data: any NSManagedObject
    func deleteToCoreData<T: NSManagedObject>(_ data: T) throws
    /// get context
    /// - Returns: current context
    func getContext() -> NSManagedObjectContext?
}

final class StoragesRepositoryImpl: StoragesRepository {
    // MARK: Private Properties

    private var realmManager: RealmManager?
    private var coreDataManager: CoreDataManager?
    private var coreDataContext: NSManagedObjectContext?

    // MARK: Public Methods

    func configure(realmManager: RealmManager, coreDataManager: CoreDataManager) {
        self.realmManager = realmManager
        self.coreDataManager = coreDataManager
        coreDataContext = coreDataManager.getContext()
    }

    func getContext() -> NSManagedObjectContext? {
        guard let coreDataContext = coreDataContext else { return nil }
        return coreDataContext
    }

    func saveToRealm<T: Object>(_ data: T) {
        realmManager?.saveData(data)
    }

    func loadToRealm<T: Object>() -> [T] {
        guard let realmData = realmManager?.loadData() as? [T] else { return [T]() }
        return realmData
    }

    func deleteToRealm<T: Object>(_ data: T) {
        realmManager?.deleteData(data)
    }

    func saveToCoreData<T: NSManagedObject>(_ data: T) throws {
        try coreDataManager?.saveData(data)
    }

    func loadToCoreData<T: NSManagedObject>(_ objectType: T.Type) throws -> [T] {
        guard let coreData = try coreDataManager?.loadData(objectType) else { return [T]() }
        return coreData
    }

    func deleteToCoreData<T: NSManagedObject>(_ data: T) throws {
        try coreDataManager?.deleteData(data)
    }
}
