//
//  HomeRepository.swift
//  iTunes-Search
//
//  Created by Berkant Dağtekin on 30.07.2023.
//

import Moya

protocol HomeRepositoryProtocol {

    func getMedias(
        parameters: SearchRequestParameters,
        callback: @escaping APIResponseCallback<SearchResponse>
    )
}

class HomeRepository: BaseRepository<HomeService, MoyaProvider<HomeService>>, HomeRepositoryProtocol {

    init(moyaProvider: MoyaProvider<HomeService>) {
        super.init(provider: moyaProvider)
    }

    func getMedias(parameters: SearchRequestParameters,callback: @escaping APIResponseCallback<SearchResponse>) {
        mRequest(.search(parameters), callback: callback)
    }
}

extension HomeRepository {

    static func getInstance() -> HomeRepository {
        return HomeRepository(moyaProvider: createMoyaProvider(targetType: HomeService.self))
    }
}
