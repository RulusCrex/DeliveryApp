// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Add To Basket
  internal static let addToBasketTitle = L10n.tr("Localizable", "addToBasketTitle", fallback: "Add To Basket")
  /// All Menu
  internal static let allMenuTag = L10n.tr("Localizable", "allMenuTag", fallback: "All Menu")
  /// Asian Cuisine
  internal static let asianCuisineTitle = L10n.tr("Localizable", "asianCuisineTitle", fallback: "Asian Cuisine")
  /// Bakeries and Confectionery
  internal static let bakeriesTitle = L10n.tr("Localizable", "bakeriesTitle", fallback: "Bakeries and Confectionery")
  /// Basket
  internal static let basketViewControllerTitle = L10n.tr("Localizable", "basketViewControllerTitle", fallback: "Basket")
  /// 12th of August, 2023
  internal static let dateLabelText = L10n.tr("Localizable", "dateLabelText", fallback: "12th of August, 2023")
  /// Fast Food
  internal static let fastFoodTitle = L10n.tr("Localizable", "fastFoodTitle", fallback: "Fast Food")
  /// Localizable.strings
  ///   DeliveryApp
  /// 
  ///   Created by Павел Дмитриевич on 06.06.2024.
  internal static let mainViewControllerTitle = L10n.tr("Localizable", "mainViewControllerTitle", fallback: "Main")
  /// Saint Petersburg
  internal static let profileCityLabelText = L10n.tr("Localizable", "profileCityLabelText", fallback: "Saint Petersburg")
  /// Account
  internal static let profileViewControllerTitle = L10n.tr("Localizable", "profileViewControllerTitle", fallback: "Account")
  /// Salads
  internal static let saladsTag = L10n.tr("Localizable", "saladsTag", fallback: "Salads")
  /// Search
  internal static let searchViewControllerTitle = L10n.tr("Localizable", "searchViewControllerTitle", fallback: "Search")
  /// Soups
  internal static let soupsTitle = L10n.tr("Localizable", "soupsTitle", fallback: "Soups")
  /// g
  internal static let weightLabelText = L10n.tr("Localizable", "weightLabelText", fallback: "g")
  /// With Fish
  internal static let withFishTag = L10n.tr("Localizable", "withFishTag", fallback: "With Fish")
  /// With Rice
  internal static let withRiceTag = L10n.tr("Localizable", "withRiceTag", fallback: "With Rice")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
