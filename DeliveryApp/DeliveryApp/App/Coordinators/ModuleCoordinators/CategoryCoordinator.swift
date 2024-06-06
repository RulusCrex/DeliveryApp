// CategoryCoordinator.swift
// HomeWorkTestApp

import UIKit

final class CategoryCoordinator: BaseCoordinator {
    // MARK: Override Methods

    override func start() {
        let assembly = CategoryAssemblyImpl()
        let viewController = assembly.createCategoryModule(coordinator: self)
        navigationController.pushViewController(viewController, animated: true)
    }

    // MARK: Public Methods

    func configure(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func showMenuModule(categoryTag: Int) {
        let menuAssembly = MenuAssemblyImpl()
        let menuCoordinator = MenuCoordinator(
            navigationController: navigationController,
            categoryTag: categoryTag,
            menuAssembly: menuAssembly,
            categoryCoordinator: self
        )
        addDependency(menuCoordinator)
        menuCoordinator.start()
        menuCoordinator.onFinish = { [weak self, weak menuCoordinator] in
            self?.removeDependency(menuCoordinator)
        }
    }
}
