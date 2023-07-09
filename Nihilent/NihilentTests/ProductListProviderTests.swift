//
//  ProductListProviderTests.swift
//  NihilentTests
//
//  Created by Rahul on 09/07/23.
//

@testable import Nihilent
import XCTest

final class ProductListProviderTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testFetchProductsSuccess() async throws {
        // Create a mock APIService
        let mockAPIService = MockAPIService()

        let encoder = JSONEncoder()
        let productResponse = ProductListResponse(products: Product.mockData())
        mockAPIService.testData = try encoder.encode(productResponse)

        // Create a ProductListProvider instance with the mock APIService
        let productListProvider = ProductListProvider(apiService: mockAPIService)

        // Perform the fetchProducts operation
        let products = try await productListProvider.fetchProducts()

        XCTAssertEqual(products.count, 3)
    }

    func testFetchProductsFailure() async throws {
        // Create a mock APIService
        let mockAPIService = MockAPIService()
        mockAPIService.testError = NetworkError.invalidURL

        // Create a ProductListProvider instance with the mock APIService
        let productListProvider = ProductListProvider(apiService: mockAPIService)

        // Perform the fetchProducts operation and catch the error
        var caughtError: Error?
        do {
            _ = try await productListProvider.fetchProducts()
        } catch {
            caughtError = error
        }

        XCTAssertNotNil(caughtError)
    }

}


