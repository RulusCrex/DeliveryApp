// СategoryModel.swift
// HomeWorkTestApp

import Foundation

// MARK: - Welcome

/// array with content for the category module
struct CategoryModel: Codable {
    let categories: [MenuCategory]

    enum CodingKeys: String, CodingKey {
        case categories = "сategories"
    }
}

// MARK: - Category

/// content for the category module
struct MenuCategory: Codable {
    let id: Int
    let name: String
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageURL = "image_url"
    }
}
