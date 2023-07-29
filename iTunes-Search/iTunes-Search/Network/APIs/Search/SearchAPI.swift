//
//  SearchAPI.swift
//  iTunesSearch
//
//  Created by Berkant Dağtekin on 29.07.2023.
//

import Foundation

// MARK: - MediaSearchable
protocol MediaSearchable {
    func search(request: SearchRequestModel, completion: @escaping (Result<SearchResponseModel, ApiError>) -> Void)
}

// MARK: - SearchAPI
final class SearchAPI: MediaSearchable {
    
    // MARK: Properties
    private let networkManager: Networking
    
    // MARK: Init
    init(networkManager: Networking) {
        self.networkManager = networkManager
    }
    
    func search(request: SearchRequestModel, completion: @escaping (Result<SearchResponseModel, ApiError>) -> Void) {
        networkManager.request(request: request, completion: completion)
    }
}
