//
//  SearchRequestParameters.swift
//  iTunes-Search
//
//  Created by Berkant Dağtekin on 30.07.2023.
//

import Foundation

// MARK: SearchRequestParameters
struct SearchRequestParameters: Codable {
    let searchTerm: String
    let limit: String
}
