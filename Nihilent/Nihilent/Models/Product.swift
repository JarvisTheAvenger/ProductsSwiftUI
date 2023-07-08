//
//  Product.swift
//  Nihilent
//
//  Created by Rahul on 07/07/23.
//

import Foundation

// MARK: - ProductResponse
struct ProductListResponse: Codable {
    let products: [Product]
}

// MARK: - Product
struct Product {
    let title: String
    let id: String
    let imageURL: String
    let price: [Price]
    let ratingCount: Double
    let isAddToCartEnable: Bool
}

extension Product: Codable, Identifiable {
    enum CodingKeys: String, CodingKey {
        case title, id, imageURL, price, ratingCount, isAddToCartEnable
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        self.id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
        self.imageURL = try container.decodeIfPresent(String.self, forKey: .imageURL) ?? ""
        self.price = try container.decodeIfPresent([Price].self, forKey: .price) ?? [Price(value: 10.0, isOfferPrice: false)]
        self.ratingCount = try container.decodeIfPresent(Double.self, forKey: .ratingCount) ?? 0.0
        self.isAddToCartEnable = try container.decodeIfPresent(Bool.self, forKey: .isAddToCartEnable) ?? false
    }
}

// MARK: - Price
struct Price: Codable {
    let value: Double
    let isOfferPrice: Bool
}
