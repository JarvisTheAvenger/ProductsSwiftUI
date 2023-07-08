//
//  ProductListViewModelTests.swift
//  NihilentTests
//
//  Created by Rahul on 08/07/23.
//

@testable import Nihilent
import XCTest

class ProductListViewModelTests: XCTestCase {
    var viewModel: ProductListViewModel!
    var mockProvider: MockProductListProvider!

    override func setUp() {
        super.setUp()
        mockProvider = MockProductListProvider()
        viewModel = ProductListViewModel(provider: mockProvider)
    }

    override func tearDown() {
        viewModel = nil
        mockProvider = nil
        super.tearDown()
    }

    func testFetchProductsSuccess() {
        // Given
        let expectation = XCTestExpectation(description: "Fetch products success")
        mockProvider.testCaseScenario = .success

        // When
        viewModel.fetchProducts()

        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(self.viewModel.isLoading == false)
            XCTAssertTrue(self.viewModel.products.count == Product.mockData().count)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5)
    }

    func testFetchProductsFailure() {
        // Given
        let expectation = XCTestExpectation(description: "Fetch products failure")
        mockProvider.testCaseScenario = .failure

        // When
        viewModel.fetchProducts()

        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(self.viewModel.isLoading == false)
            XCTAssertTrue(self.viewModel.products.isEmpty)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5)
    }

    func testToggleFavorite() {
        // Given
        let productId = "123"
        XCTAssertFalse(viewModel.favorites.contains(productId))

        // When
        viewModel.toggleFavorite(for: productId)

        // Then
        XCTAssertTrue(viewModel.favorites.contains(productId))

        // When
        viewModel.toggleFavorite(for: productId)

        // Then
        XCTAssertFalse(viewModel.favorites.contains(productId))
    }
}

