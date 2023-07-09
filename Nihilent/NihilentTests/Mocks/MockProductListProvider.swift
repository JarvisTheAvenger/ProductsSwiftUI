//
//  MockProductListProvider.swift
//  NihilentTests
//
//  Created by Rahul on 08/07/23.
//

@testable import Nihilent
import Foundation
import XCTest

enum TestCaseScenario {
    case success
    case failure
}

final class MockProductListProvider: ProductListProviderProtocol {
    var apiService: APIServiceProtocol = MockAPIService()
    var testCaseScenario: TestCaseScenario = .success

    func fetchProducts() async throws -> [Product] {
        switch testCaseScenario {
        case .success:
            return Product.mockData()
        case .failure:
            throw NSError(domain: "MockErrorDomain", code: 1, userInfo: nil)
        }
    }
}

