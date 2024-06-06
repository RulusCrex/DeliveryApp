// MenuViewController.swift
// HomeWorkTestApp

import UIKit

/// responsible for visual elements of the category module
protocol MenuViewController {
    /// customizing visual elements
    /// - Parameter view: view with all visual elements
    /// - Parameter categoryTag: tag category
    /// - Parameter viewModel: view model
    func configure(categoryTag: Int, viewModel: MenuViewModel)
}

final class MenuViewControllerImpl: UIViewController {
    // MARK: Private Properties

    private var menuTag = 0
    private var feedForCell: [Dish] = []
    private var imageArray: [UIImage] = []

    private var feedForSectionWithTag: [MenuTagData] = []
    private var viewModel: MenuViewModel?

    private enum CategoryEnum: Int {
        case bakeries
        case fastFood
        case asianCuisine
        case soups
    }

    private enum CollectionViewTypeEnum: Int {
        case tag
        case menu
    }

    // MARK: Visual Components

    private var userImageView = UIImageView()
    private var userImage = UIImage(named: "userImage")
    private var menuFlowLayout = UICollectionViewFlowLayout()
    private var menuTagFlowLayout = UICollectionViewFlowLayout()
    lazy var menuCollectionView = UICollectionView(frame: .zero, collectionViewLayout: menuFlowLayout)
    lazy var menuTagButtonCollectionView = UICollectionView(frame: .zero, collectionViewLayout: menuTagFlowLayout)

    // MARK: Life Cycle

    override func viewDidLoad() {
        view.backgroundColor = .white
        setupNavigationController()
        setupUserImageView()
        setupMenuTagButtonCollectionView()
        setupMenuCollectionView()
    }

    // MARK: Private Methods

    private func setupUserImageView() {
        userImageView.image = userImage
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        userImageView.layer.masksToBounds = true
        userImageView.layer.cornerRadius = 20
        NSLayoutConstraint.activate([
            userImageView.heightAnchor.constraint(equalToConstant: 40),
            userImageView.widthAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func setupMenuTagButtonCollectionView() {
        if let flowLayout = menuTagButtonCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.itemSize = CGSize(width: 100, height: 35)
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumInteritemSpacing = 0
            flowLayout.minimumLineSpacing = 10
        }
        view.addSubview(menuTagButtonCollectionView)
        menuTagButtonCollectionView.dataSource = self
        menuTagButtonCollectionView.delegate = self
        menuTagButtonCollectionView.tag = 0
        menuTagButtonCollectionView.translatesAutoresizingMaskIntoConstraints = false
        menuTagButtonCollectionView.register(
            MenuTagButtonCollectionViewCell.self,
            forCellWithReuseIdentifier: MenuTagButtonCollectionViewCell.identifier
        )
        NSLayoutConstraint.activate([
            menuTagButtonCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 109),
            menuTagButtonCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            menuTagButtonCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            menuTagButtonCollectionView.heightAnchor.constraint(equalToConstant: 35)
        ])
    }

    private func setupMenuCollectionView() {
        if let flowLayout = menuCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .vertical
            flowLayout.itemSize = CGSize(width: 109, height: 128)
            flowLayout.minimumInteritemSpacing = -14
            flowLayout.minimumLineSpacing = 10
        }
        view.addSubview(menuCollectionView)
        menuCollectionView.dataSource = self
        menuCollectionView.delegate = self
        menuCollectionView.tag = 1
        menuCollectionView.translatesAutoresizingMaskIntoConstraints = false
        menuCollectionView.register(
            MenuCollectionViewCell.self, forCellWithReuseIdentifier: MenuCollectionViewCell.identifier
        )
        NSLayoutConstraint.activate([
            menuCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
            menuCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 7),
            menuCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -7),
            menuCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }

    private func setupTitle(categoryTag: Int) {
        switch CategoryEnum(rawValue: categoryTag) {
        case .bakeries:
            title = L10n.bakeriesTitle
        case .fastFood:
            title = L10n.fastFoodTitle
        case .asianCuisine:
            title = L10n.asianCuisineTitle
        case .soups:
            title = L10n.soupsTitle
        default:
            break
        }
    }

    private func setupNavigationController() {
        navigationController?.navigationBar.tintColor = .black
    }

    private func setUpdateHandler() {
        viewModel?.updateData = { [weak self] in
            DispatchQueue.main.async {
                guard let viewModel = self?.viewModel else { return }
                guard let self = self else { return }
                self.imageArray = viewModel.getImages()
                self.feedForCell = viewModel.getMenuData()
                self.feedForSectionWithTag = viewModel.getTagData()
                self.menuTagButtonCollectionView.reloadData()
                self.menuCollectionView.reloadData()
            }
        }
    }
}

// MARK: - MenuViewControllerProtocol

extension MenuViewControllerImpl: MenuViewController {
    func tapOnTagButton(selectedTag: Int) {
        viewModel?.tapOnTagButton(selectedTag: selectedTag)
    }

    func tapOnMenuButton(selectedDish: Dish) {
        viewModel?.tapOnMenuButton(dish: selectedDish)
    }

    func configure(categoryTag: Int, viewModel: MenuViewModel) {
        setupTitle(categoryTag: categoryTag)
        self.viewModel = viewModel
        setUpdateHandler()
        self.viewModel?.showError = { [weak self] error in
            DispatchQueue.main.async {
                self?.showErrorAlert(errorMessage: error)
            }
        }
    }
}

// MARK: - UITableViewDelegate

extension MenuViewControllerImpl: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        switch CollectionViewTypeEnum(rawValue: collectionView.tag) {
        case .tag:
            menuTag = indexPath.row
            tapOnTagButton(selectedTag: indexPath.row)
            menuTagButtonCollectionView.reloadData()
            menuCollectionView.reloadData()
        case .menu:
            tapOnMenuButton(selectedDish: feedForCell[indexPath.row])
        default:
            break
        }
    }
}

// MARK: - UITableViewDataSource

extension MenuViewControllerImpl: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch CollectionViewTypeEnum(rawValue: collectionView.tag) {
        case .tag:
            return feedForSectionWithTag.count
        case .menu:
            return feedForCell.count
        default:
            return 1
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        switch CollectionViewTypeEnum(rawValue: collectionView.tag) {
        case .tag:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MenuTagButtonCollectionViewCell.identifier, for: indexPath
            ) as? MenuTagButtonCollectionViewCell
            else {
                return UICollectionViewCell()
            }
            cell.configure(with: feedForSectionWithTag[indexPath.row])
            return cell
        case .menu:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MenuCollectionViewCell.identifier, for: indexPath
            ) as? MenuCollectionViewCell
            else {
                return UICollectionViewCell()
            }
            cell.configure(with: feedForCell[indexPath.row], image: imageArray[indexPath.row])
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}
