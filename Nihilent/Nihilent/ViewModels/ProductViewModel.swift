//
//  ProductViewModel.swift
//  Nihilent
//
//  Created by Rahul on 08/07/23.
//

import SwiftUI

protocol ProductViewModelProtocol: ObservableObject {
    var title: String { get }
    var image: UIImage? { get }
    var isAddToCartEnabled: Bool { get }
    var isInWishlist: Bool { get }
    var rating: Double { get }
    var formattedPrice: String { get }

    func toggleFavorite()
    func loadImage() async
}

final class ProductViewModel: ObservableObject, Identifiable, ProductViewModelProtocol {
    private let product: Product
    private let productListViewModel: any ProductListViewModelProtocol

    @Published var image: UIImage? // Track the loaded image separately

    var title: String { product.title }
    var isAddToCartEnabled: Bool { product.isAddToCartEnable }

    var isInWishlist: Bool { return productListViewModel.favorites.contains(product.id) }
    var rating: Double { product.ratingCount }
    var id: String { product.id }

    var formattedPrice: String {
       "$\(String(format: "%.2f", product.price.first?.value ?? 0.0))"
    }

    init(product: Product, productListViewModel: any ProductListViewModelProtocol) {
        self.product = product
        self.productListViewModel = productListViewModel
    }

    func toggleFavorite() {
        if let index = productListViewModel.products.firstIndex(where: { $0.id == id }) {
            productListViewModel.products[index].objectWillChange.send() // Notify SwiftUI of the changes
            productListViewModel.toggleFavorite(for: id)
        }
    }

    func loadImage() {
        Task {
            await productListViewModel.loadProductImage(for: product)
            DispatchQueue.main.async { [weak self] in

                if let product = self?.product {
                    self?.image = self?.productListViewModel.loadedImage(for: product)
                }
            }
        }
    }

}
