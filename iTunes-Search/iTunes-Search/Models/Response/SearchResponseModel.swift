//
//  SearchResponseModel.swift
//  iTunesSearch
//
//  Created by Berkant Dağtekin on 29.07.2023.
//

import Foundation

// MARK: - SearchResponseModel
struct SearchResponseModel: Codable {
    let resultCount: Int?
    let results: [MediaItem]?
    
    static func emptyInstance() -> SearchResponseModel {
        return .init(resultCount: .zero, results: [])
    }
}

// MARK: - MediaItem
struct MediaItem: Codable, Hashable{
    let wrapperType: String?
    let kind: String?
    let collectionName: String?
    let artworkUrl100: String?
    let collectionPrice: Double?
    let trackPrice: Double?
    let releaseDate: String?
    let currency: String?
    let trackId: Int?
    let longDescription: String?
}
