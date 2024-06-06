// ProxyService.swift
// HomeWorkTestApp

import UIKit

/// responsible for loading images
protocol ProxyService {
    /// configure
    /// - Parameters:
    ///   - networkManager: responsible for working with the Internet
    ///   - cacheService: responsible for interaction with FileManager
    func configure(
        networkManager: NetworkManager,
        cacheService: CacheService
    )
    /// loads the image from the cache, if it doesn’t work, downloads it from the Internet
    /// - Parameters:
    ///   - url: url for image
    ///   - completion: return UImage
    func getImageFromCaсhe(url: String, completion: @escaping (Swift.Result<UIImage, Error>) -> ())
}

final class ProxyServiceImpl: ProxyService {
    // MARK: Private Properties

    private var networkManager: NetworkManager?
    private var cacheService: CacheService?

    // MARK: Public Methods

    func configure(
        networkManager: NetworkManager,
        cacheService: CacheService
    ) {
        self.networkManager = networkManager
        self.cacheService = cacheService
    }

    func getImageFromCaсhe(url: String, completion: @escaping (Swift.Result<UIImage, Error>) -> ()) {
        if let image = cacheService?.loadImage(url: url) {
            completion(.success(image))
            return
        }
        networkManager?.uploadImage(url: url) { [weak self] result in
            switch result {
            case let .success(image):
                self?.cacheService?.saveImage(name: url, image: image)
                completion(.success(image))
            case let .failure(error):
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
}
