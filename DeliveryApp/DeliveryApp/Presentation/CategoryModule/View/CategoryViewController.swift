// CategoryViewController.swift
// HomeWorkTestApp

import UIKit

/// responsible for visual elements of the category module
protocol CategoryViewController {
    /// configure
    /// - Parameter viewModel: viewModel
    func configure(viewModel: CategoryViewModel)
}

final class CategoryViewControllerImpl: UIViewController {
    // MARK: Private Properties

    private var viewModel: CategoryViewModel?
    private var categoryData: [MenuCategory] = []
    private var imageArray: [UIImage] = []

    private enum Constants {
        static let profileImageSystemName = "userImage"
        static let profileLabelImageSystemSystemName = "mappin"
    }

    // MARK: Visual Components

    private var profileLabelImage = UIImage(systemName: Constants.profileLabelImageSystemSystemName)
    private var profileImage = UIImage(named: Constants.profileImageSystemName)
    private var profileLabelImageView = UIImageView()
    private var profileImageView = UIImageView()
    private var profileCityLabel = UILabel()
    private var tableView = UITableView()
    private var profileView = UIView()
    private var dateLabel = UILabel()

    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupProfileView()
        setupProfileCityLabel()
        setupProfileImageView()
        setupProfileLabelImageView()
        setupDateLabel()
        setupTableView()
        setupBackBarButtonItem()
    }

    // MARK: Private Methods

    private func setUpdateHandler() {
        viewModel?.updateData = { [weak self] in
            guard let viewModel = self?.viewModel else { return }
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.imageArray = viewModel.getImages()
                self.categoryData = viewModel.getCategoryData()
                self.tableView.reloadData()
            }
        }
    }

    private func setupBackBarButtonItem() {
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "",
            style: .plain,
            target: self,
            action: nil
        )
    }

    private func setupProfileView() {
        view.addSubview(profileView)
        profileView.addSubview(profileImageView)
        profileView.addSubview(dateLabel)
        profileView.addSubview(profileCityLabel)
        profileView.addSubview(profileLabelImageView)
        profileView.backgroundColor = .white
        profileView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalTo: view.topAnchor),
            profileView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileView.heightAnchor.constraint(equalToConstant: 101)
        ])
    }

    private func setupProfileCityLabel() {
        profileCityLabel.translatesAutoresizingMaskIntoConstraints = false
        profileCityLabel.text = L10n.profileCityLabelText
        NSLayoutConstraint.activate([
            profileCityLabel.topAnchor.constraint(equalTo: profileView.topAnchor, constant: 55),
            profileCityLabel.leadingAnchor.constraint(equalTo: profileView.leadingAnchor, constant: 35),
        ])
    }

    private func setupProfileImageView() {
        profileImageView.image = profileImage
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.cornerRadius = 20
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: profileView.topAnchor, constant: 55),
            profileImageView.trailingAnchor.constraint(equalTo: profileView.trailingAnchor, constant: -15),
            profileImageView.heightAnchor.constraint(equalToConstant: 40),
            profileImageView.widthAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func setupProfileLabelImageView() {
        profileLabelImageView.image = profileLabelImage
        profileLabelImageView.translatesAutoresizingMaskIntoConstraints = false
        profileLabelImageView.tintColor = .black
        NSLayoutConstraint.activate([
            profileLabelImageView.topAnchor.constraint(equalTo: profileView.topAnchor, constant: 55),
            profileLabelImageView.leadingAnchor.constraint(equalTo: profileView.leadingAnchor, constant: 5),
            profileLabelImageView.heightAnchor.constraint(equalToConstant: 30),
            profileLabelImageView.widthAnchor.constraint(equalToConstant: 30)
        ])
    }

    private func setupDateLabel() {
        dateLabel.text = L10n.dateLabelText
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.textColor = .gray
        dateLabel.font = dateLabel.font.withSize(13)
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: profileView.topAnchor, constant: 75),
            dateLabel.leadingAnchor.constraint(equalTo: profileView.leadingAnchor, constant: 35),
        ])
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorColor = .white
        tableView.register(CategoryCell.self, forCellReuseIdentifier: CategoryCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: profileView.bottomAnchor, constant: .zero),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - CategoryViewControllerProtocol

extension CategoryViewControllerImpl: CategoryViewController {
    func configure(viewModel: CategoryViewModel) {
        self.viewModel = viewModel
        setUpdateHandler()
        self.viewModel?.showError = { [weak self] error in
            self?.showErrorAlert(errorMessage: error)
        }
    }
}

// MARK: - UITableViewDelegate

extension CategoryViewControllerImpl: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.tapOnCategoryButton(categoryTag: indexPath.row)
    }
}

// MARK: - UITableViewDataSource

extension CategoryViewControllerImpl: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categoryData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.identifier) as? CategoryCell
        else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.configure(with: categoryData[indexPath.row], image: imageArray[indexPath.row])
        return cell
    }
}
