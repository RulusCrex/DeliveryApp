// RealmManager.swift
// HomeWorkTestApp

import RealmSwift

protocol RealmManager {
    /// save data to realm
    /// - Parameter data: any object
    func saveData<T: Object>(_ data: T)
    /// load data to realm
    /// - Returns: any object
    func loadData<T: Object>() -> [T]
    /// delete data from realm
    /// - Parameter data: any object
    func deleteData<T: Object>(_ data: T)
}

final class RealmManagerImpl: RealmManager {
    // MARK: Public Methods

    func loadData<T: Object>() -> [T] {
        guard let realm = try? Realm() else { return [] }
        let loadedData = realm.objects(T.self)
        return Array(loadedData)
    }

    func deleteData<T: Object>(_ data: T) {
        guard let realm = try? Realm() else { return }
        let oldData = realm.objects(T.self)
        realm.beginWrite()
        realm.delete(oldData)
        try? realm.commitWrite()
    }

    func saveData<T: Object>(_ data: T) {
        guard let realm = try? Realm() else { return }
        let oldData = realm.objects(T.self)
        realm.beginWrite()
        realm.delete(oldData)
        realm.add(data)
        try? realm.commitWrite()
    }
}
