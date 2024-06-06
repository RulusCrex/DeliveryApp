// TabBarViewModel.swift
// HomeWorkTestApp

import UIKit

/// contains business logic
protocol TabBarViewModel {
    /// creates view controllers for the tab bar
    /// - Returns: array of view controllers
    func generateTabBar() -> [UIViewController]
}

final class TabBarViewModelImpl: TabBarViewModel {
    // MARK: Private Properties

    private enum Constants {
        static let mainViewControllerTitleImageSystemName = "house"
        static let searchViewControllerImageSystemName = "magnifyingglass"
        static let basketViewControllerImageSystemName = "basket"
        static let profileViewControllerImageSystemName = "person.crop.circle"
    }

    // MARK: Public Methods

    func generateTabBar() -> [UIViewController] {
        let mainNC = ViewController()
        let viewControllers = [
            generateVC(
                viewController: mainNC,
                title: L10n.mainViewControllerTitle,
                image: UIImage(systemName: Constants.mainViewControllerTitleImageSystemName)
            ),
            generateVC(
                viewController: UIViewController(),
                title: L10n.searchViewControllerTitle,
                image: UIImage(systemName: Constants.searchViewControllerImageSystemName)
            ),
            generateVC(
                viewController: UIViewController(),
                title: L10n.basketViewControllerTitle,
                image: UIImage(systemName: Constants.basketViewControllerImageSystemName)
            ),
            generateVC(
                viewController: UIViewController(),
                title: L10n.profileViewControllerTitle,
                image: UIImage(systemName: Constants.profileViewControllerImageSystemName)
            )
        ]
        return viewControllers
    }

    // MARK: Private Methods

    private func generateVC(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
    }
}
