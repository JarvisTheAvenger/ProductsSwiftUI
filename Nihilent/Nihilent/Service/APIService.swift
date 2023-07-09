//
//  APIService.swift
//  Nihilent
//
//  Created by Rahul on 09/07/23.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
}

protocol APIServiceProtocol {
    func fetchData<T: Decodable>(from urlString: String) async throws -> T
}

final class APIService: APIServiceProtocol {
    func fetchData<T: Decodable>(from urlString: String) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            throw NetworkError.invalidResponse
        }
    }
}
