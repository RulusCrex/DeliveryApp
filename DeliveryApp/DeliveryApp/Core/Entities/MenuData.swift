// MenuData.swift
// HomeWorkTestApp

import Foundation

// MARK: - Welcome

/// array for module menu
struct Menu: Codable {
    let dishes: [Dish]
}

// MARK: - Dish

/// content for the menu screen
struct Dish: Codable {
    let id: Int
    let name: String
    let price: Int
    let weight: Int
    let description: String
    let imageURL: String
    let tags: [Tag]

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case price
        case weight
        case description
        case imageURL = "image_url"
        case tags = "tegs"
    }
}

/// dish teg
enum Tag: String, Codable {
    case allMenu = "Все меню"
    case withRice = "С рисом"
    case withFish = "С рыбой"
    case salads = "Салаты"
}
