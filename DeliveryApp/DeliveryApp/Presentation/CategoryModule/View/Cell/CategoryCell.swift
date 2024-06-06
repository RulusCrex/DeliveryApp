// CategoryCell.swift
// HomeWorkTestApp

import UIKit

final class CategoryCell: UITableViewCell {
    // MARK: Visual Components

    private var cellImageView = UIImageView()
    private var cellLabel = UILabel()

    // MARK: Private Properties

    static let identifier = String(describing: CategoryCell.self)

    // MARK: Public Methods

    func configure(with categoryFeed: MenuCategory, image: UIImage) {
        cellImageView.image = image
        cellLabel.text = categoryFeed.name
        setupCellImageView()
        setupCellLabel()
    }

    // MARK: Private Methods

    private func setupCellImageView() {
        contentView.addSubview(cellImageView)
        cellImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellImageView.heightAnchor.constraint(equalToConstant: 148),
            cellImageView.widthAnchor.constraint(equalToConstant: 343),
            cellImageView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            cellImageView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            cellImageView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            cellImageView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor)
        ])
    }

    private func setupCellLabel() {
        contentView.addSubview(cellLabel)
        cellLabel.translatesAutoresizingMaskIntoConstraints = false
        cellLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        cellLabel.numberOfLines = 2
        NSLayoutConstraint.activate([
            cellLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: 10),
            cellLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: 10),
            cellLabel.widthAnchor.constraint(equalToConstant: 170)
        ])
    }
}
