// MenuTagButtonCollectionViewCell.swift
// HomeWorkTestApp

import UIKit

final class MenuTagButtonCollectionViewCell: UICollectionViewCell {
    // MARK: Visual Components

    private var cellButton = UIButton()
    private var cellView = UIView()
    private var cellLabel = UILabel()

    // MARK: Public properties

    static let identifier = String(describing: MenuTagButtonCollectionViewCell.self)

    // MARK: Public Methods

    func configure(with menuFeed: MenuTagData) {
        cellLabel.text = menuFeed.tagName
        setupCellView()
        setupCellLabel()
        updateBackgroundColor()
        if menuFeed.tagCollorBool {
            cellView.backgroundColor = .systemBlue
        }
    }

    // MARK: Private Methods

    private func updateBackgroundColor() {
        setupCellLabel()
        cellView.backgroundColor = .tertiaryLabel
        cellLabel.textColor = .black
    }

    private func setupCellView() {
        addSubview(cellView)
        cellView.addSubview(cellLabel)
        cellView.layer.cornerRadius = 10
        cellView.backgroundColor = .systemGray2
        cellView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellView.heightAnchor.constraint(equalToConstant: 35),
            cellView.widthAnchor.constraint(equalToConstant: 86),
            cellView.topAnchor.constraint(equalTo: topAnchor),
            cellView.bottomAnchor.constraint(equalTo: bottomAnchor),
            cellView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cellView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    private func setupCellLabel() {
        cellLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 6),
            cellLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 6)
        ])
    }
}
