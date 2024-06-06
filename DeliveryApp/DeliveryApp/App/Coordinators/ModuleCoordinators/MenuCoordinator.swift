// MenuCoordinator.swift
// HomeWorkTestApp

import UIKit

final class MenuCoordinator: BaseCoordinator {
    // MARK: Public properties

    var onFinish: VoidHandler?
    var currentViewController = UIViewController()

    // MARK: Private properties

    private var categoryTag = 0
    private var menuAssembly: MenuAssembly?
    private var categoryCoordinator: CategoryCoordinator?

    // MARK: Initialization

    init(
        navigationController: UINavigationController,
        categoryTag: Int,
        menuAssembly: MenuAssembly,
        categoryCoordinator: CategoryCoordinator
    ) {
        self.categoryTag = categoryTag
        self.menuAssembly = menuAssembly
        self.categoryCoordinator = categoryCoordinator
        super.init(navigationController: navigationController)
    }

    // MARK: Override Methods

    override func start() {
        guard let menuAssembly = menuAssembly else { return }
        currentViewController = menuAssembly.createMenuModule(
            coordinator: self,
            categoryTag: categoryTag
        )
        navigationController.pushViewController(currentViewController, animated: true)
    }

    // MARK: Public Methods

    func showProductModule(selectedDish: Dish, currentViewController: UIViewController) {
        let productAssembly = ProductAssemblyImpl()
        let productCoordinator = ProductCoordinator(
            productAssembly: productAssembly,
            menuCoordinator: self,
            selectedDish: selectedDish,
            currentViewController: currentViewController,
            navigationController: navigationController
        )
        addDependency(productCoordinator)
        productCoordinator.start()
        productCoordinator.onFinish = { [weak self, weak productCoordinator] in
            self?.removeDependency(productCoordinator)
        }
    }
}
