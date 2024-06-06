// Array+Extension.swift
// HomeWorkTestApp

import Foundation

extension Array {
    subscript(safe index: Int?) -> Element? {
        get {
            guard let index = index else { return nil }
            return index < count && index >= 0 ? self[index] : nil
        }
        set(newValue) {
            guard let index = index, let newValue = newValue else { return }
            self[index] = newValue
        }
    }
}
