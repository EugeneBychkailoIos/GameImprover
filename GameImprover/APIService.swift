//
//  APIService.swift
//  GameImprover
//
//  Created by jekster on 17.10.2024.
//

import Foundation

protocol ApiServiceProtoc {
    func getUserInfo(key: String, id: String, _ compl: @escaping (Result<[Player], Error>)->())
    
}

class Api {
    private let networkService: NetworkServiceProtocol
    fileprivate let decoder = JSONDecoder()
    
    init (networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    private let base = "https://api.steampowered.com/"
 
}

extension Api: ApiServiceProtoc {
    
    func getUserInfo(key: String, id: String, _ compl: @escaping (Result<[Player], Error>) -> ()) {
        guard let url = URL(string: base + Midpoints.steamUser.pass + Endpoints.getPlayerSummaries(key, id).pass) else {
            compl(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        print(url)
        
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        
        self.networkService.request(request: request) { [unowned self] (result) in
            switch result {
            case .success(let data):
                do {
                    let userInfo = try self.decoder.decode(UserInfo.self, from: data)
                    compl(.success(userInfo.response.players))
                    
                } catch {
                    compl(.failure(error))
                }
            case .fail(let error):
                compl(.failure(error))
            }
        }
    }

}
