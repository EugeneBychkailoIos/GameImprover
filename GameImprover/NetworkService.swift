//
//  NetworkService.swift
//  GameImprover
//
//  Created by jekster on 17.10.2024.
//

import Foundation

protocol NetworkServiceProtocol {
    func request(request: URLRequest, handler: @escaping (NetworkService.Result) -> Void)
    
}

class NetworkService {
    public enum Result {
        case success(Data)
        case fail(Error)
    }
}

extension NetworkService: NetworkServiceProtocol {
    func request(request: URLRequest, handler: @escaping (NetworkService.Result)-> Void) {
        let task = URLSession.shared.dataTask(with: request) { (data, _, Error) in
            if let Error = Error {
                handler(Result.fail(Error))
                return
            }
            if let data = data {
                handler(Result.success(data))
                return
            }
        }
        task.resume()
    }
}
