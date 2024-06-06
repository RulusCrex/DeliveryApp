// UIViewController+Extension.swift
// HomeWorkTestApp

import UIKit

extension UIViewController {
    private enum Constants {
        static let errorAction = "Ok"
    }

    func showErrorAlert(errorMessage: String) {
        let alert = UIAlertController(title: "", message: errorMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: Constants.errorAction, style: .cancel)
        alert.addAction(action)
        print(errorMessage)
        present(alert, animated: true)
    }
}
