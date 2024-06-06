// TabBarAssembly.swift
// HomeWorkTestApp

import UIKit

/// creating a TabBar module
protocol TabBarAssembly {
    /// creating module
    /// - Returns: TabBar module
    func createTabBarModule() -> UIViewController
}

final class TabBarAssemblyImpl: TabBarAssembly {
    // MARK: Public Methods

    func createTabBarModule() -> UIViewController {
        let viewModel = TabBarViewModelImpl()
        let viewController = TabBarViewControllerImpl()
        viewController.configure(viewModel: viewModel)
        return viewController
    }
}
