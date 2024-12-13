//
//  NetworkService.swift
//  GameImprover
//
//  Created by jekster on 17.10.2024.
//

import Foundation

protocol NetworkServiceProtocol {
    func request(request: URLRequest) async throws -> Data
}

class NetworkService: NetworkServiceProtocol {
    func request(request: URLRequest) async throws -> Data {
        let (data, _) = try await URLSession.shared.data(for: request)
        return data
    }
}

