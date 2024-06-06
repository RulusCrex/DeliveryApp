// BaseCoordinator.swift
// HomeWorkTestApp

import UIKit

/// defines the interface for coordinators in the application architecture,
/// which manage navigation and coordination between different view controllers.
protocol Coordinator: AnyObject {
    /// list of child coordinators that manage the navigation or business logic subsections under their control.
    var childCoordinators: [Coordinator] { get set }
    /// a navigation controller that is used to manage a stack of view controllers.
    var navigationController: UINavigationController { get set }
    /// starts the main coordinator process
    func start()
}

/// implementation of the coordinator protocol
class BaseCoordinator: Coordinator {
    // MARK: Public properties

    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    // MARK: init

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: Public Methods

    func start() {}

    func addDependency(_ coordinator: Coordinator) {
        for element in childCoordinators where element === coordinator {
            return
        }
        childCoordinators.append(coordinator)
    }

    func removeDependency(_ coordinator: Coordinator?) {
        guard let coordinator = coordinator else { return }
        if let index = childCoordinators.firstIndex(where: { $0 === coordinator }) {
            childCoordinators.remove(at: index)
        }
    }
}
