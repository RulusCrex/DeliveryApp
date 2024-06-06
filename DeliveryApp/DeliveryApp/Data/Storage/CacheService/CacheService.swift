// CacheService.swift
// HomeWorkTestApp

import UIKit

/// responsible for interaction with FileManager
protocol CacheService {
    /// save UImage in FileManager
    /// - Parameters:
    ///   - name: key
    ///   - image: selected objc
    func saveImage(name: String, image: UIImage)
    /// load UIImage in FileManager
    /// - Parameter url: key
    /// - Returns: selected objc
    func loadImage(url: String) -> UIImage?
}

final class CacheServiceImpl {
    // MARK: Private Properties

    private var images = [String: UIImage]()
    private static let pathName: String = {
        let pathName = "images"
        guard let cachesDirectory = FileManager.default.urls(
            for: .cachesDirectory,
            in: .userDomainMask
        ).first else { return pathName }
        let url = cachesDirectory.appendingPathComponent(pathName, isDirectory: true)
        if !FileManager.default.fileExists(atPath: url.path) {
            try? FileManager.default.createDirectory(
                at: url,
                withIntermediateDirectories: true,
                attributes: nil
            )
        }
        return pathName
    }()

    // MARK: Private Methods

    private func getFilePath(url: String) -> String? {
        guard let cachesDirectory = FileManager.default.urls(
            for: .cachesDirectory,
            in: .userDomainMask
        ).first else { return nil }
        let hashName = url.split(separator: "/").last ?? "default"
        return cachesDirectory.appendingPathComponent(CacheServiceImpl.pathName + "/" + hashName).path
    }
}

// MARK: - CategoryPresenterProtocol

extension CacheServiceImpl: CacheService {
    func saveImage(name: String, image: UIImage) {
        guard let fileName = getFilePath(url: name),
              let data = image.pngData() else { return }
        FileManager.default.createFile(
            atPath: fileName,
            contents: data,
            attributes: nil
        )
    }

    func loadImage(url: String) -> UIImage? {
        guard let fileName = getFilePath(url: url),
              let image = UIImage(contentsOfFile: fileName) else { return nil }
        DispatchQueue.main.async {
            self.images[url] = image
        }
        return image
    }
}
