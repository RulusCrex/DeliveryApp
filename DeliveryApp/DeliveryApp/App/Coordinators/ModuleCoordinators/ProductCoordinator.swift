// ProductCoordinator.swift
// HomeWorkTestApp

import UIKit

final class ProductCoordinator: BaseCoordinator {
    // MARK: - Public properties

    var onFinish: VoidHandler?

    // MARK: Private properties

    private var productAssembly: ProductAssembly?
    private var menuCoordinator: MenuCoordinator?
    private var selectedDish: Dish?
    private var currentViewController: UIViewController?

    // MARK: Initialization

    init(
        productAssembly: ProductAssembly,
        menuCoordinator: MenuCoordinator,
        selectedDish: Dish,
        currentViewController: UIViewController,
        navigationController: UINavigationController
    ) {
        self.productAssembly = productAssembly
        self.menuCoordinator = menuCoordinator
        self.selectedDish = selectedDish
        self.currentViewController = currentViewController
        super.init(navigationController: navigationController)
    }

    // MARK: Override Methods

    override func start() {
        guard let productAssembly = productAssembly,
              let selectedDish = selectedDish,
              let currentViewController = currentViewController else { return }
        let viewController = productAssembly.createProductModule(
            coordinator: self,
            selectedDish: selectedDish
        )
        viewController.modalPresentationStyle = .overFullScreen
        currentViewController.present(viewController, animated: true)
    }

    // MARK: Public Methods

    func popViewController() {
        currentViewController?.dismiss(animated: true)
    }
}
