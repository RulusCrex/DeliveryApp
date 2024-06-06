// NetworkManager.swift
// HomeWorkTestApp

import CoreData
import WebKit

/// responsible for working with the Internet
protocol NetworkManager {
    /// configure
    func configure(storagesRepository: StoragesRepository)
    /// downloads UIImage from the Internet
    /// - Parameters:
    ///   - url: url for image
    ///   - completion: return UIImage/error
    func uploadImage(url: String, completion: @escaping (Swift.Result<UIImage, Error>) -> ())
    /// downloads category from the Internet
    /// - Parameter completion: return [Category]/error
    func getCategory(completion: @escaping (Swift.Result<[MenuCategory], Error>) -> ())
    /// downloads Dish from the Internet
    /// - Parameter completion: return [Dish]/error
    func getMenu(completion: @escaping (Swift.Result<[Dish], Error>) -> ())
}

final class NetworkManagerImpl: NetworkManager {
    // MARK: Private properties

    private let urlCategoryString = "https://run.mocky.io/v3/3061b929-6358-4ffc-868a-4ab90846d7a5"
    private let urlMenuString = "https://run.mocky.io/v3/1db5af8a-1ebe-448c-b8ae-9c6aea465424"
    private let monitor = NWPathMonitor()
    private var isReachable = true
    private var storagesRepository: StoragesRepository?
    private var coreDataContext: NSManagedObjectContext?

    // MARK: Public Methods

    func configure(storagesRepository: StoragesRepository) {
        self.storagesRepository = storagesRepository
        monitor.pathUpdateHandler = { path in
            self.isReachable = path.status == .satisfied
        }
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
        coreDataContext = storagesRepository.getContext()
    }

    func uploadImage(url: String, completion: @escaping (Swift.Result<UIImage, Error>) -> ()) {
        guard let imageURL = URL(string: url) else {
            completion(.failure(NSError(domain: "Invalid URL", code: .zero, userInfo: nil)))
            return
        }

        URLSession.shared.dataTask(with: imageURL) { data, _, _ in
            guard let data = data, let image = UIImage(data: data) else {
                completion(.failure(NSError(domain: "Invalid data", code: .zero, userInfo: nil)))
                return
            }
            completion(.success(image))
        }.resume()
    }

    func getCategory(completion: @escaping (Swift.Result<[MenuCategory], Error>) -> ()) {
        if !isReachable {
            do {
                let coreData = try storagesRepository?.loadToCoreData(CategoryCoreData.self)
                guard let coreData = coreData else { return }
                let categoryData = coreData.map { category in
                    MenuCategory(
                        id: Int(category.id),
                        name: category.name ?? "",
                        imageURL: category.imageURL ?? ""
                    )
                }
                completion(.success(categoryData))
            } catch {
                completion(.failure(error))
            }
        }

        guard let categoryURL = URL(string: urlCategoryString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: .zero, userInfo: nil)))
            return
        }

        URLSession.shared.dataTask(with: categoryURL) { data, _, error in
            guard let data = data else { return }
            do {
                let categoryData = try JSONDecoder().decode(CategoryModel.self, from: data)
                completion(.success(categoryData.categories))
                try self.storagesRepository?.deleteToCoreData(CategoryCoreData())
                let _: [CategoryCoreData] = categoryData.categories.compactMap { category in
                    guard let context = self.coreDataContext else { return nil }
                    let data = CategoryCoreData(context: context)
                    data.id = Int64(category.id)
                    data.name = category.name
                    data.imageURL = category.imageURL
                    do {
                        try self.storagesRepository?.saveToCoreData(data)
                    } catch {
                        print("Error saving to CoreData: \(error)")
                    }
                    return data
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    func getMenu(completion: @escaping (Swift.Result<[Dish], Error>) -> ()) {
        if !isReachable {
            do {
                let coreData = try storagesRepository?.loadToCoreData(DishCoreData.self)
                guard let coreData = coreData else { return }
                let menuData = coreData.map { dishCoreData in
                    let tegs = dishCoreData.tegs?.compactMap { Tag(rawValue: $0) } ?? []
                    return Dish(
                        id: Int(dishCoreData.id),
                        name: dishCoreData.name ?? "",
                        price: Int(dishCoreData.price),
                        weight: Int(dishCoreData.weight),
                        description: dishCoreData.description,
                        imageURL: dishCoreData.imageURL ?? "",
                        tags: tegs
                    )
                }
                completion(.success(menuData))
            } catch {
                completion(.failure(error))
            }
        }

        guard let menuURL = URL(string: urlMenuString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: .zero, userInfo: nil)))
            return
        }

        URLSession.shared.dataTask(with: menuURL) { data, _, error in
            guard let data = data else { return }
            do {
                let menuData = try JSONDecoder().decode(Menu.self, from: data)
                completion(.success(menuData.dishes))
                try self.storagesRepository?.deleteToCoreData(DishCoreData())
                let _: [DishCoreData] = menuData.dishes.compactMap { dish in
                    guard let context = self.coreDataContext else { return nil }
                    let data = DishCoreData(context: context)
                    data.id = Int64(dish.id)
                    data.name = dish.name
                    data.price = Int64(dish.price)
                    data.weight = Int64(dish.weight)
                    data.definition = dish.description
                    data.imageURL = dish.imageURL
                    do {
                        try self.storagesRepository?.saveToCoreData(data)
                    } catch {
                        print("Error saving to CoreData: \(error)")
                    }
                    return data
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
