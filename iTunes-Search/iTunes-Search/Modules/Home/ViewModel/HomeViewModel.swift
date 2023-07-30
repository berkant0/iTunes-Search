//
//  HomeViewModel.swift
//  iTunes-Search
//
//  Created by Berkant Dağtekin on 29.07.2023.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func successSearchService()
    func failSearchService(error: ApiError)
}

final class HomeViewModel {

    // MARK: Properties
    private let homeRepository: HomeRepositoryProtocol
    private let alertManager: AlertShowable
    private let loadingManager: Loading

    weak var delegate: HomeViewModelDelegate? = nil

    private var responseSearch: SearchResponse = .emptyInstance()

    var medias: [MediaItem] {
        return responseSearch.results ?? []
    }

    // Pagination
    private let itemLimit = 20
    private var pageNumber = 1

    init(homeRepository: HomeRepositoryProtocol,
        alertManager: AlertShowable,
        loadingManager: Loading) {
        self.homeRepository = homeRepository
        self.alertManager = alertManager
        self.loadingManager = loadingManager
    }

    func getSearchServiceWithPagination(term: String) {
        if !isReachLastPagePagination() {
            self.pageNumber += 1
            self.searchService(with: term, limit: self.pageNumber * self.itemLimit)
        } else {
            self.pageNumber = 1
        }
    }

    func searchService(with term: String, limit: Int) {
        loadingManager.show()
        homeRepository.getMedias(parameters: .init(searchTerm: term, limit: String(limit))) { [weak self] response, error in
            guard let self = self else { return }
            loadingManager.hide()
            self.responseSearch = .emptyInstance()
            if let error = error {
                self.alertManager.showAlert(with: error)
            } else if let response = response {
                guard response.resultCount ?? .zero > 0 else {
                    self.delegate?.failSearchService(error: .notFound)
                    return
                }
                self.responseSearch = response
                self.delegate?.successSearchService()
            }
        }
    }

    private func isReachLastPagePagination() -> Bool {
        let maxPage = 10
        return self.pageNumber >= maxPage
    }
}
