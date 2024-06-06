// TabBarViewController.swift
// HomeWorkTestApp

import UIKit

/// contains visual elements TabBar module
protocol TabBarViewController {
    /// customizing visual elements
    /// - Parameter viewModel: selected TabBarViewModel
    func configure(viewModel: TabBarViewModel)
}

final class TabBarViewControllerImpl: UITabBarController, TabBarViewController {
    // MARK: Private Properties

    private var viewModel: TabBarViewModel?

    // MARK: Public Methods

    func configure(viewModel: TabBarViewModel) {
        self.viewModel = viewModel
        viewControllers = viewModel.generateTabBar()
        tabBar.backgroundColor = .white
    }
}
