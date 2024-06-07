// ProductViewController.swift
// HomeWorkTestApp

import UIKit

/// /// responsible for visual elements of the category module
protocol ProductViewController {
    /// configure product view controller
    /// - Parameter viewModel: product view model
    func configure(viewModel: ProductViewModel)
}

final class ProductViewControllerImpl: UIViewController {
    // MARK: Private Properties

    private var selectedDish: Dish?
    private var viewModel: ProductViewModel?

    // MARK: Visual Components

    private var backgroundView = UIView()
    private var dishLabel = UILabel()
    private var buyButton = UIButton()
    private var priceLabel = UILabel()
    private var dishImageView = UIImageView()
    private var weightLabel = UILabel()
    private var dishInfoLabel = UILabel()
    private var cancelButton = UIButton()
    private var likeButton = UIButton()

    private enum Constants {
        static let cancelButtonSystemName = "pencil.slash"
        static let likeButtonSystemName = "heart"
        static let rubleSymbol = "₽"
    }

    // MARK: Life Cycle

    override func viewDidLoad() {
        view.backgroundColor = .black.withAlphaComponent(0.5)
        setupBackgroundView()
        setupBuyButton()
        setupPriceLabel()
        setupDishImageView()
        setupDishLabel()
        setupWeightLabel()
        setupDishInfoLabel()
        setupCancelButton()
        setupLikeButton()
    }

    // MARK: Private Methods

    private func setupBackgroundView() {
        view.addSubview(backgroundView)
        backgroundView.addSubview(buyButton)
        backgroundView.addSubview(priceLabel)
        backgroundView.addSubview(dishImageView)
        backgroundView.addSubview(dishLabel)
        backgroundView.addSubview(weightLabel)
        backgroundView.addSubview(dishInfoLabel)
        backgroundView.addSubview(cancelButton)
        backgroundView.addSubview(likeButton)
        backgroundView.layer.cornerRadius = 15
        backgroundView.backgroundColor = .white
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundView.heightAnchor.constraint(equalToConstant: 446),
            backgroundView.widthAnchor.constraint(equalToConstant: 343),
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor, constant: 183),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
    }

    private func setupBuyButton() {
        buyButton.setTitle(L10n.addToBasketTitle, for: .normal)
        buyButton.backgroundColor = .link
        buyButton.layer.cornerRadius = 7
        buyButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buyButton.heightAnchor.constraint(equalToConstant: 48),
            buyButton.widthAnchor.constraint(equalToConstant: 311),
            buyButton.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 10),
            buyButton.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -14)
        ])
    }

    private func setupPriceLabel() {
        priceLabel.text = String(selectedDish?.price ?? .zero) + Constants.rubleSymbol
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            priceLabel.heightAnchor.constraint(equalToConstant: 15),
            priceLabel.widthAnchor.constraint(equalToConstant: 70),
            priceLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 10),
            priceLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 265)
        ])
    }

    private func setupDishImageView() {
        dishImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dishImageView.heightAnchor.constraint(equalToConstant: 198),
            dishImageView.widthAnchor.constraint(equalToConstant: 204),
            dishImageView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 65),
            dishImageView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 40)
        ])
    }

    private func setupDishLabel() {
        dishLabel.text = selectedDish?.name
        dishLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dishLabel.heightAnchor.constraint(equalToConstant: 17),
            dishLabel.widthAnchor.constraint(equalToConstant: 187),
            dishLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 10),
            dishLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 240)
        ])
    }

    private func setupWeightLabel() {
        weightLabel.text = String(selectedDish?.weight ?? .zero) + L10n.weightLabelText
        weightLabel.translatesAutoresizingMaskIntoConstraints = false
        weightLabel.textColor = .gray
        NSLayoutConstraint.activate([
            weightLabel.heightAnchor.constraint(equalToConstant: 15),
            weightLabel.widthAnchor.constraint(equalToConstant: 70),
            weightLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 60),
            weightLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 265)
        ])
    }

    private func setupDishInfoLabel() {
        dishInfoLabel.text = selectedDish?.description
        dishInfoLabel.numberOfLines = 6
        dishInfoLabel.font = dishInfoLabel.font.withSize(12)
        dishInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dishInfoLabel.heightAnchor.constraint(equalToConstant: 110),
            dishInfoLabel.widthAnchor.constraint(equalToConstant: 321),
            dishInfoLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 13),
            dishInfoLabel.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -60)
        ])
    }

    private func setupCancelButton() {
        cancelButton.setImage(UIImage(systemName: Constants.cancelButtonSystemName), for: .normal)
        cancelButton.layer.cornerRadius = 8
        cancelButton.backgroundColor = .white
        cancelButton.tintColor = .gray
        cancelButton.addTarget(self, action: #selector(settingCloseAction), for: .touchUpInside)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cancelButton.heightAnchor.constraint(equalToConstant: 40),
            cancelButton.widthAnchor.constraint(equalToConstant: 40),
            cancelButton.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -20),
            cancelButton.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 10)
        ])
    }

    private func setupLikeButton() {
        likeButton.setImage(UIImage(systemName: Constants.likeButtonSystemName), for: .normal)
        likeButton.layer.cornerRadius = 8
        likeButton.tintColor = .gray
        likeButton.backgroundColor = .white
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            likeButton.heightAnchor.constraint(equalToConstant: 40),
            likeButton.widthAnchor.constraint(equalToConstant: 40),
            likeButton.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -53),
            likeButton.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 10)
        ])
    }

    private func getData() {
        dishImageView.image = viewModel?.getImage()
        selectedDish = viewModel?.getSelectedDishData()
    }

    private func setErrorHandler() {}

    // MARK: Action

    @objc private func settingCloseAction() {
        tapOnBackButton()
    }
}

// MARK: - ProductViewControllerProtocol

extension ProductViewControllerImpl: ProductViewController {
    func configure(viewModel: ProductViewModel) {
        self.viewModel = viewModel
        getData()
        self.viewModel?.showError = { [weak self] error in
            self?.showErrorAlert(errorMessage: error)
        }
    }

    func uploadImageError(errorMessage: String) {
        showErrorAlert(errorMessage: errorMessage)
    }

    func setDishes(selectedDish: Dish, dishImage: UIImage) {
        dishImageView.image = dishImage
        self.selectedDish = selectedDish
    }

    func tapOnBackButton() {
        viewModel?.tapOnBackButton()
    }
}
