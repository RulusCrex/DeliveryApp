// CategoryAssembly.swift
// HomeWorkTestApp

import UIKit

/// creating a category module
protocol CategoryAssembly {
    /// creating module
    /// - Parameter router: router for category
    /// - Returns: category module
    func createCategoryModule(coordinator: CategoryCoordinator) -> UIViewController
}

final class CategoryAssemblyImpl: CategoryAssembly {
    // MARK: Public Methods

    func createCategoryModule(coordinator: CategoryCoordinator) -> UIViewController {
        let proxyService = ProxyServiceImpl()
        let networkService = NetworkManagerImpl()
        let viewController = CategoryViewControllerImpl()
        let viewModel = CategoryViewModelImpl()
        let storagesRepository = StoragesRepositoryImpl()
        storagesRepository.configure(
            realmManager: RealmManagerImpl(),
            coreDataManager: CoreDataManagerImpl()
        )
        proxyService.configure(
            networkManager: networkService,
            cacheService: CacheServiceImpl()
        )
        networkService.configure(storagesRepository: storagesRepository)
        viewController.configure(viewModel: viewModel)
        viewModel.configure(
            proxyService: proxyService,
            coordinator: coordinator,
            networkService: networkService
        )
        return viewController
    }
}
