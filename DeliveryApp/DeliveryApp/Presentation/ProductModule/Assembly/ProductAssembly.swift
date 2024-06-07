// ProductAssembly.swift
// HomeWorkTestApp

import UIKit

/// /// creating a product module
protocol ProductAssembly {
    /// creating module
    /// - Parameter router: router for product module
    /// - Returns: product module
    func createProductModule(coordinator: ProductCoordinator, selectedDish: Dish) -> UIViewController
}

final class ProductAssemblyImpl: ProductAssembly {
    // MARK: Public Methods

    func createProductModule(coordinator: ProductCoordinator, selectedDish: Dish) -> UIViewController {
        let proxyService = ProxyServiceImpl()
        let networkManager = NetworkManagerImpl()
        let viewController = ProductViewControllerImpl()
        let viewModel = ProductViewModelImpl()
        let storagesRepository = StoragesRepositoryImpl()
        storagesRepository.configure(
            realmManager: RealmManagerImpl(),
            coreDataManager: CoreDataManagerImpl()
        )
        networkManager.configure(storagesRepository: storagesRepository)
        proxyService.configure(
            networkManager: networkManager,
            cacheService: CacheServiceImpl()
        )
        viewModel.configure(
            proxyService: proxyService,
            coordinator: coordinator,
            selectedDish: selectedDish
        )
        viewController.configure(viewModel: viewModel)
        return viewController
    }
}
