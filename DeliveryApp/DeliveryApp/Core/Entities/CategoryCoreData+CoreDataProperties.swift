// CategoryCoreData+CoreDataProperties.swift
// HomeWorkTestApp

import CoreData
import Foundation
/// model for saving and loading category to core data
public extension CategoryCoreData {
    @NSManaged var id: Int64
    @NSManaged var name: String?
    @NSManaged var imageURL: String?
}
