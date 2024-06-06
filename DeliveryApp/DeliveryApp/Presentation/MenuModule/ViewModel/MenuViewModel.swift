// MenuViewModel.swift
// HomeWorkTestApp

import UIKit

/// contains all business logic of menu
protocol MenuViewModel {
    /// configure
    /// - Parameters:
    ///   - viewController: menu view controller
    ///   - proxyService: service
    ///   - coordinator: menu coordinator
    func configure(
        proxyService: ProxyService,
        coordinator: MenuCoordinator,
        networkService: NetworkManager
    )
    /// сlicking on the category button triggers the transition to the next screen
    /// - Parameter dish: selected dish
    func tapOnMenuButton(dish: Dish)
    /// Clicking to select a food type
    /// - Parameter selectedTag: category tag
    func tapOnTagButton(selectedTag: Int)
    /// handles errors
    var showError: StringHandler? { get set }
    /// handles update
    var updateData: VoidHandler? { get set }
    /// get menu feed
    /// - Returns: menu feed
    func getMenuData() -> [Dish]
    /// get images
    /// - Returns: array images
    func getImages() -> [UIImage]
    /// get feed for tag section
    /// - Returns: [MenuTagData]
    func getTagData() -> [MenuTagData]
}

final class MenuViewModelImpl {
    // MARK: Public Properties

    var showError: StringHandler?
    var updateData: VoidHandler?

    // MARK: Private Properties

    private var viewController: MenuViewController?
    private var proxyService: ProxyService?
    private var networkService: NetworkManager?
    private var coordinator: MenuCoordinator?
    private var feedForMenu: [Dish] = []
    private var feedForSectionWithTag: [MenuTagData] = []
    private var feedForCell: [Dish] = []
    private var imageArray: [UIImage] = []
    private enum MenuTagTypes: Int {
        case allMenu
        case salads
        case withRice
        case withFish
    }

    // MARK: Private Methods

    private func setupMenuData(menuTag: Int) {
        var tagStatus = Array(repeating: false, count: 4)
        let allTags = [
            L10n.allMenuTag,
            L10n.saladsTag,
            L10n.withFishTag,
            L10n.withRiceTag
        ]
        switch MenuTagTypes(rawValue: menuTag) {
        case .allMenu:
            feedForCell = feedForMenu
            tagStatus[safe: .zero] = true
            feedForSectionWithTag = zip(allTags, tagStatus).map(MenuTagData.init)
        case .salads:
            feedForCell = feedForMenu.filter { $0.tags.contains(.salads) }
            tagStatus[safe: 1] = true
            feedForSectionWithTag = zip(allTags, tagStatus).map(MenuTagData.init)
        case .withRice:
            feedForCell = feedForMenu.filter { $0.tags.contains(.withRice) }
            tagStatus[safe: 2] = true
            feedForSectionWithTag = zip(allTags, tagStatus).map(MenuTagData.init)
        case .withFish:
            feedForCell = feedForMenu.filter { $0.tags.contains(.withFish) }
            tagStatus[safe: 3] = true
            feedForSectionWithTag = zip(allTags, tagStatus).map(MenuTagData.init)
        default:
            break
        }
    }

    private func getImage(feedForMenu: [Dish]) {
        imageArray.removeAll()
        for currentData in feedForMenu {
            proxyService?.getImageFromCaсhe(url: currentData.imageURL) { [weak self] result in
                switch result {
                case let .success(image):
                    self?.imageArray.append(image)
                case let .failure(error):
                    self?.showError?(error.localizedDescription)
                }
            }
        }
        updateData?()
    }

    private func getMenu() {
        networkService?.getMenu { [weak self] result in
            switch result {
            case let .success(menuData):
                self?.feedForMenu = menuData
                self?.setupMenuData(menuTag: 0)
                self?.getImage(feedForMenu: menuData)
            case let .failure(error):
                self?.showError?(error.localizedDescription)
            }
        }
    }
}

// MARK: - MenuPresenterProtocol

extension MenuViewModelImpl: MenuViewModel {
    func configure(
        proxyService: ProxyService,
        coordinator: MenuCoordinator,
        networkService: NetworkManager
    ) {
        self.proxyService = proxyService
        self.coordinator = coordinator
        self.networkService = networkService
        getMenu()
    }

    func tapOnTagButton(selectedTag: Int) {
        setupMenuData(menuTag: selectedTag)
        getImage(feedForMenu: feedForCell)
    }

    func tapOnMenuButton(dish: Dish) {
        coordinator?.showProductModule(
            selectedDish: dish,
            currentViewController: coordinator?.currentViewController ?? UIViewController()
        )
    }

    func getImages() -> [UIImage] {
        imageArray
    }

    func getMenuData() -> [Dish] {
        feedForCell
    }

    func getTagData() -> [MenuTagData] {
        feedForSectionWithTag
    }
}
