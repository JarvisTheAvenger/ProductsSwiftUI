//
//  ProductListProvider.swift
//  Nihilent
//
//  Created by Rahul on 07/07/23.
//

import Foundation

protocol ProductListProviderProtocol {
    func fetchProductList() async throws -> [Product]
}

enum NetworkError: Error {
    case invalidURL
    case invalidData
}

final class ProductListProvider: ProductListProviderProtocol {
    private let urlString = "https://run.mocky.io/v3/2f06b453-8375-43cf-861a-06e95a951328"

    func fetchProductList() async throws -> [Product] {
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(ProductListResponse.self, from: data)
        return response.products
    }
}
