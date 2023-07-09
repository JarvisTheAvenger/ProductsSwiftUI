//
//  NihilentTests.swift
//  NihilentTests
//
//  Created by Rahul on 08/07/23.
//

@testable import Nihilent
import XCTest

final class ProductViewModelTests: XCTestCase {
    var viewModel: ProductViewModel!
    var productListViewModel: (any ProductListViewModelProtocol)!

    override func setUp() {
        super.setUp()
        let product = Product.mockData().first!
        productListViewModel = ProductListViewModelMock()
        viewModel = ProductViewModel(product: product, productListViewModel: productListViewModel)
    }

    override func tearDown() {
        viewModel = nil
        productListViewModel = nil
        super.tearDown()
    }

    func testTitle() {
        XCTAssertEqual(viewModel.title, "Test Product")
    }

    func testIsAddToCartEnabled() {
        XCTAssertTrue(viewModel.isAddToCartEnabled)
    }

    func testIsInWishlist() {
        XCTAssertFalse(viewModel.isInWishlist)

        // When
        productListViewModel.toggleFavorite(for: "123")

        // Then
        XCTAssertTrue(viewModel.isInWishlist)
    }

    func testRating() {
        XCTAssertEqual(viewModel.rating, 4.5)
    }

    func testFormattedPrice() {
        XCTAssertEqual(viewModel.formattedPrice, "$10.00")
    }

    func testToggleFavorite() {
        // Given
        XCTAssertFalse(productListViewModel.favorites.contains("123"))

        productListViewModel.fetchProducts()

        // When
        viewModel.toggleFavorite()

        // Then
        XCTAssertTrue(productListViewModel.favorites.contains("123"))

        // When
        viewModel.toggleFavorite()

        // Then
        XCTAssertFalse(productListViewModel.favorites.contains("123"))
    }
}
