//
//  HomeService.swift
//  iTunesSearch
//
//  Created by Berkant Dağtekin on 30.07.2023.
//

import Moya

enum HomeService {
    case search(SearchRequestParameters)
}

extension HomeService: MTargetType {

    var path: String {
        switch self {
        case .search(let parameters):
            return generateEndPoint(lastPath: "\(Constants.API.search)/media=music&term=\(parameters.searchTerm)&limit=\(parameters.limit)")
        }
    }

    var method: MoyaMethod {
        return .post
    }

    var task: MoyaTask {
        return .requestPlain
    }
}

