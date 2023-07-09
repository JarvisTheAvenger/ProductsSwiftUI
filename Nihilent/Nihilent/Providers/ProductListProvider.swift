//
//  ProductListProvider.swift
//  Nihilent
//
//  Created by Rahul on 07/07/23.
//

import Foundation

protocol ProductListProviderProtocol {
    var apiService: any APIServiceProtocol { get }
    func fetchProducts() async throws -> [Product]
}

final class ProductListProvider: ProductListProviderProtocol {
    let apiService: any APIServiceProtocol

    init(apiService: any APIServiceProtocol) {
        self.apiService = apiService
    }

    func fetchProducts() async throws -> [Product] {
        do {
            let response: ProductListResponse = try await apiService.fetchData(from: API.productList)
            return response.products
        } catch {
            throw error
        }
    }
}
