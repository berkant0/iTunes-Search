//
//  Definitions.swift
//  iTunesSearch
//
//  Created by Berkant Dağtekin on 29.07.2023.
//

import Moya

// MARK: Provider
func createMoyaProvider<Target: TargetType>(targetType: Target.Type) -> MoyaProvider<Target> {
    let provider = MoyaProvider<Target>()
    provider.session.sessionConfiguration.timeoutIntervalForRequest = 120
    return provider
}

// MARK: RequestParameters
typealias APIRequestParameters = [String: Any]

// MARK: Typealiases
typealias MoyaMethod = Moya.Method
typealias MoyaTask = Task

// MARK: Definitions
let DefaultJSONEncoding = JSONEncoding.default
let DefaultURLEncoding = URLEncoding.default

// MARK: TargetType
public protocol MTargetType: TargetType { }

extension MTargetType {

    var baseURL: URL {
        return URL(string: Constants.API.baseUrl)!
    }

    public var headers: [String: String]? {
        let headers: [String: String] = [
            "Content-Type": "application/json; charset=UTF-8",
            "Accept": "*/*"
        ]

        return headers
    }

    var sampleData: Data {
        return Data()
    }

    func generateEndPoint(lastPath: String) -> String {
        return lastPath
    }
}

