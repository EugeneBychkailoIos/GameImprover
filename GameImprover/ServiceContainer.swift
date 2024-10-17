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
//    lazy var imageService: ImageService = ImageService()
}
