//
//  MockProductListViewModel.swift
//  NihilentTests
//
//  Created by Rahul on 08/07/23.
//

@testable import Nihilent
import UIKit

class ProductListViewModelMock: ProductListViewModelProtocol {
    var products: [ProductViewModel] = []
    var favorites: Set<String> = []
    var isLoading: Bool = false
    var productImages: [String: UIImage] = [:]

    func loadProductImage(for product: Product) async {}
    func loadedImage(for product: Product) -> UIImage? { nil }

    func fetchProducts() {
        products = Product.mockData().map { ProductViewModel(product: $0, productListViewModel: self) }
    }

    func toggleFavorite(for id: String) {
        if favorites.contains(id) {
            favorites.remove(id)
        } else {
            favorites.insert(id)
        }
    }
}
