// MenuCollectionViewCell.swift
// HomeWorkTestApp

import UIKit

final class MenuCollectionViewCell: UICollectionViewCell {
    // MARK: Visual Components

    private var cellMenuImageView = UIImageView()
    private var cellLabel = UILabel()

    // MARK: Private Properties

    static let identifier = String(describing: MenuCollectionViewCell.self)

    // MARK: Public Methods

    func configure(with menuFeed: Dish, image: UIImage) {
        cellMenuImageView.image = image
        cellLabel.text = menuFeed.name
        setupCellImageView()
        setupCellLabel()
    }

    // MARK: Private Methods

    private func setupCellLabel() {
        addSubview(cellLabel)
        cellLabel.numberOfLines = 2
        cellLabel.font = cellLabel.font.withSize(12)
        cellLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellLabel.heightAnchor.constraint(equalToConstant: 30),
            cellLabel.widthAnchor.constraint(equalToConstant: 109),
            cellLabel.topAnchor.constraint(equalTo: cellMenuImageView.bottomAnchor, constant: 5),
            cellLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            cellLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            cellLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    private func setupCellImageView() {
        addSubview(cellMenuImageView)
        cellMenuImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellMenuImageView.heightAnchor.constraint(equalToConstant: 109),
            cellMenuImageView.widthAnchor.constraint(equalToConstant: 109),
            cellMenuImageView.topAnchor.constraint(equalTo: topAnchor),
            cellMenuImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cellMenuImageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
