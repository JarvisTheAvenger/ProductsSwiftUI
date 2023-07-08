//
//  ProductListViewModel.swift
//  Nihilent
//
//  Created by Rahul on 07/07/23.
//

import SwiftUI

protocol ProductListViewModelProtocol: ObservableObject {
    var products: [ProductViewModel] { get }
    var favorites: Set<String> { get }
    var isLoading: Bool { get }
    var productImages: [String: UIImage] { get }

    func fetchProducts()
    func toggleFavorite(for id: String)

    func loadProductImage(for product: Product) async
    func loadedImage(for product: Product) -> UIImage?
}

final class ProductListViewModel: ObservableObject, ProductListViewModelProtocol {
    @Published var products: [ProductViewModel] = []
    @Published var favorites: Set<String> = []
    @Published var isLoading: Bool = false
    @Published var productImages: [String: UIImage] = [:] // Cache for product images

    private let provider: ProductListProviderProtocol

    init(provider: ProductListProviderProtocol) {
        self.provider = provider
    }

    func fetchProducts() {
        isLoading = true

        Task {
            do {
                let productList = try await provider.fetchProductList()
                DispatchQueue.main.async {
                    self.products = productList.map { ProductViewModel(product: $0, productListViewModel: self) }
                    self.isLoading = false
                }
            } catch {
                // Handle error
                print("Failed to fetch product list: \(error)")

                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
        }
    }

    func toggleFavorite(for id: String) {
        if favorites.contains(id) {
            favorites.remove(id)
        } else {
            favorites.insert(id)
        }
    }

    func loadProductImage(for product: Product) async {
        guard let imageUrl = URL(string: product.imageURL) else { return }

        do {
            let (data, _) = try await URLSession.shared.data(from: imageUrl)
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.productImages[product.id] = image
                }
            }
        } catch {
            // Handle error
            print("Failed to load product image: \(error)")
        }
    }

    func loadedImage(for product: Product) -> UIImage? {
        return productImages[product.id]
    }

}
