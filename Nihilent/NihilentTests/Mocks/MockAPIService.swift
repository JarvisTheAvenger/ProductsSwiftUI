//
//  MockAPIService.swift
//  NihilentTests
//
//  Created by Rahul on 09/07/23.
//

@testable import Nihilent
import Foundation

final class MockAPIService: APIServiceProtocol {
    var testData: Data?
    var testError: Error?

    func fetchData<T: Decodable>(from urlString: String) async throws -> T {
        if let error = testError {
            throw error
        }

        guard let data = testData else {
            throw NetworkError.invalidResponse
        }

        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            throw error
        }
    }
}
