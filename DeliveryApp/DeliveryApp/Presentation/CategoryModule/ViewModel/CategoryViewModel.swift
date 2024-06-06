// CategoryViewModel.swift
// HomeWorkTestApp

import UIKit

/// contains all business logic of categories
protocol CategoryViewModel {
    /// configure
    /// - Parameters:
    ///   - proxyService: service
    ///   - coordinator: category coordinator
    func configure(
        proxyService: ProxyService,
        coordinator: CategoryCoordinator,
        networkService: NetworkManager
    )
    /// сlicking on the category button triggers the transition to the next screen
    /// - Parameter categoryTag: tag category
    func tapOnCategoryButton(categoryTag: Int)
    /// request to get category names and images from the service
    /// - Returns: returns feed for vc
    func getImages() -> [UIImage]
    /// returns feed for vc
    /// - Returns: feed for vc
    func getCategoryData() -> [MenuCategory]
    /// handles errors
    var showError: StringHandler? { get set }
    /// handles update
    var updateData: VoidHandler? { get set }
}

final class CategoryViewModelImpl {
    // MARK: Public Properties

    var showError: StringHandler?
    var updateData: VoidHandler?

    // MARK: Private Properties

    private var coordinator: CategoryCoordinator?
    private var networkService: NetworkManager?
    private var proxyService: ProxyService?
    private var imageArray: [UIImage] = []
    private var feedForCategory: [MenuCategory] = []

    // MARK: Private Methods

    private func getImage(feedForCategory: [MenuCategory]) {
        for currentData in feedForCategory {
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

    private func getCategory() {
        networkService?.getCategory { [weak self] result in
            switch result {
            case let .success(categoryData):
                self?.getImage(feedForCategory: categoryData)
                self?.feedForCategory = categoryData
            case let .failure(error):
                self?.showError?(error.localizedDescription)
            }
        }
    }

    private func setupNavigationController() {
        coordinator?.navigationController.navigationBar.tintColor = .black
        coordinator?.navigationController.navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "",
            style: .plain,
            target: self,
            action: nil
        )
    }
}

// MARK: - CategoryPresenterProtocol

extension CategoryViewModelImpl: CategoryViewModel {
    func getImages() -> [UIImage] {
        imageArray
    }

    func getCategoryData() -> [MenuCategory] {
        feedForCategory
    }

    func configure(
        proxyService: ProxyService,
        coordinator: CategoryCoordinator,
        networkService: NetworkManager
    ) {
        self.coordinator = coordinator
        self.proxyService = proxyService
        self.networkService = networkService
        getCategory()
    }

    func tapOnCategoryButton(categoryTag: Int) {
        coordinator?.showMenuModule(categoryTag: categoryTag)
    }
}
