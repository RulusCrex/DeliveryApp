// MenuAssembly.swift
// HomeWorkTestApp

import UIKit

/// creating a menu module
protocol MenuAssembly {
    /// creating module
    /// - Parameter router: router for menu
    /// - Parameter categoryTag: category tag
    /// - Returns: category module
    func createMenuModule(coordinator: MenuCoordinator, categoryTag: Int) -> UIViewController
}

final class MenuAssemblyImpl: MenuAssembly {
    // MARK: Public Methods

    func createMenuModule(coordinator: MenuCoordinator, categoryTag: Int) -> UIViewController {
        let proxyService = ProxyServiceImpl()
        let networkManager = NetworkManagerImpl()
        let viewController = MenuViewControllerImpl()
        let viewModel = MenuViewModelImpl()
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
            networkService: networkManager
        )
        viewController.configure(
            categoryTag: categoryTag,
            viewModel: viewModel
        )
        return viewController
    }
}
