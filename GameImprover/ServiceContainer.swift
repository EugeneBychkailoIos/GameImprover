//
//  ServiceContainer.swift
//  GameImprover
//
//  Created by jekster on 17.10.2024.
//

import Foundation

class ServiceContainer {
    
    static let shared = ServiceContainer()
    
    let networkService: NetworkServiceProtocol = NetworkService()
    
    lazy var apiService: ApiServiceProtoc = Api(networkService: self.networkService)
//    let authService: AuthService = AuthService()
    lazy var imageService: ImageService = ImageService()
}
