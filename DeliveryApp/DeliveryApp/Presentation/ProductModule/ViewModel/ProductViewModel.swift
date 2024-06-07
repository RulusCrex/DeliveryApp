// ProductViewModel.swift
// HomeWorkTestApp

import UIKit

/// contains all business logic of categories
protocol ProductViewModel {
    /// configure
    /// - Parameters:
    ///   - proxyService: service
    ///   - coordinator: category coordinator
    ///   - selectedDish: feed for module
    func configure(
        proxyService: ProxyService,
        coordinator: ProductCoordinator,
        selectedDish: Dish
    )
    /// сlicking on the category button triggers the transition to the next screen
    func tapOnBackButton()
    /// handles errors
    var showError: StringHandler? { get set }
    /// handles update
    var updateData: VoidHandler? { get set }
    /// get images for view
    /// - Returns: image
    func getImage() -> UIImage
    /// get feed for view
    /// - Returns: selected dish
    func getSelectedDishData() -> Dish?
}

final class ProductViewModelImpl {
    var showError: StringHandler?
    var updateData: VoidHandler?

    // MARK: Private Properties

    private var viewController: ProductViewController?
    private var proxyService: ProxyService?
    private var coordinator: ProductCoordinator?
    private var selectedDish: Dish?
    private var productImage = UIImage()

    // MARK: Private Methods

    private func getImage(selectedDish: Dish) {
        proxyService?.getImageFromCaсhe(url: selectedDish.imageURL) { [weak self] result in
            switch result {
            case let .success(image):
                self?.productImage = image
                self?.updateData?()
            case let .failure(error):
                self?.showError?(error.localizedDescription)
            }
        }
    }
}

// MARK: - ProductPresenterProtocol

extension ProductViewModelImpl: ProductViewModel {
    func configure(
        proxyService: ProxyService,
        coordinator: ProductCoordinator,
        selectedDish: Dish
    ) {
        self.proxyService = proxyService
        self.coordinator = coordinator
        self.selectedDish = selectedDish
        getImage(selectedDish: selectedDish)
    }

    func tapOnBackButton() {
        coordinator?.popViewController()
    }

    func getSelectedDishData() -> Dish? {
        guard let selectedDish = selectedDish else { return nil }
        return selectedDish
    }

    func getImage() -> UIImage {
        productImage
    }
}
