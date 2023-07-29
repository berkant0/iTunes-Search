//
//  SearchRequestModel.swift
//  iTunesSearch
//
//  Created by Berkant Dağtekin on 29.07.2023.
//

import Foundation

final class SearchRequestModel: RequestModel {
    
    // MARK: Properties
    private let searchTerm: String
    private let limit: String

    // MARK: Init
    init(searchTerm: String, limit: String) {
        self.searchTerm = searchTerm
        self.limit = limit
    }

    override var path: String {
        return Constants.API.search
    }

    override var method: RequestMethod {
        .post
    }

    override var parameters: [String : Any?] {
        return [
            "term": self.searchTerm,
            "media": "music",
            "limit": self.limit
        ]
    }
}
