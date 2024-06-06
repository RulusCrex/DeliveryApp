// DishCoreData+CoreDataProperties.swift
// HomeWorkTestApp

import CoreData
import Foundation
/// model for saving and loading dish to core data
public extension DishCoreData {
    @NSManaged var id: Int64
    @NSManaged var name: String?
    @NSManaged var price: Int64
    @NSManaged var weight: Int64
    @NSManaged var definition: String?
    @NSManaged var imageURL: String?
    @NSManaged var tegs: [String]?
}
