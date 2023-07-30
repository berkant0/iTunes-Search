//
//  BaseRepository.swift
//  iTunesSearch
//
//  Created by Berkant Dağtekin on 29.07.2023.
//

import Moya

typealias APIResponseCallback<T: Codable> = (T?, ApiError?) -> Void

class BaseRepository<Target: TargetType, Provider: MoyaProvider<Target>> {

    private var provider: Provider

    init(provider: Provider) {
        self.provider = provider
    }

    func mRequest<T: Codable>(_ target: Target, callback: @escaping APIResponseCallback<T>) {
        provider.request(target) { (result) in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                if statusCode == 400 {
                    callback(nil, .badRequest)
                } else if statusCode == 404 {
                    callback(nil, .notFound)
                } else if statusCode == 500 {
                    callback(nil, .serverError)
                } else if (statusCode >= 200 && statusCode < 300) || statusCode == 422 {
                    do {
                        let decodedResponse = try JSONDecoder().decode(T.self, from: response.data)
                        callback(decodedResponse, nil)
                    } catch (let error) {
                        print("unknown_data -> \(error)")
                        callback(nil, .unknownError)
                    }
                } else {
                    callback(nil, .commonError)
                }
            case .failure(let error):
                switch error {
                case .underlying(let underlyingError, _):
                    switch underlyingError.asAFError {
                    case .sessionTaskFailed(let sessionTaskFailedError):
                        let nsErrorCode = (sessionTaskFailedError as NSError).code
                        if nsErrorCode == -1009 { // no internet
                            callback(nil, .connectionError)
                        } else if nsErrorCode == NSURLErrorTimedOut {
                            callback(nil, .timeOut)
                        } else {
                            callback(nil, .commonError)
                        }
                    default:
                        callback(nil, .commonError)
                    }
                default:
                    callback(nil, .commonError)
                }
            }
        }
    }
}
