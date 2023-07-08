//
//  Product+Extension.swift
//  NihilentTests
//
//  Created by Rahul on 08/07/23.
//

@testable import Nihilent
import Foundation

extension Product {
    static func mockData() -> [Product] {
        let product1 = Product(title: "Test Product",
                               id: "123",
                               imageURL: "test_image_url",
                               price: [Price(value: 10.00, isOfferPrice: false)],
                               ratingCount: 4.5,
                               isAddToCartEnable: true)

        let product2 = Product(title: "Test Product2",
                              id: "2",
                              imageURL: "test_image_url2",
                              price: [Price(value: 80, isOfferPrice: false)],
                              ratingCount: 3.0,
                              isAddToCartEnable: true)

        let product3 = Product(title: "Test Product3",
                              id: "3",
                              imageURL: "test_image_url3",
                              price: [Price(value: 80, isOfferPrice: false)],
                              ratingCount: 4.0,
                              isAddToCartEnable: true)

        return [product1, product2, product3]
    }
}
