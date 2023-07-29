//
//  HomeBuilder.swift
//  iTunes-Search
//
//  Created by Berkant Dağtekin on 29.07.2023.
//

import UIKit

final class HomeBuilder {
    static func build() -> UINavigationController {
        let controller = HomeViewController()
        
        let urlSession = URLSession.shared
        
        let loadingManager = LoadingManager.shared

        let alertManager = AlertManager.shared
        
        let networkManager = NetworkManager(session: urlSession)
        
        let searchApi = SearchAPI(networkManager: networkManager)
                
        let navigationController = UINavigationController(rootViewController: controller)

        controller.viewModel = HomeViewModel(searchApi: searchApi, alertManager: alertManager, loadingManager: loadingManager)

        return navigationController
    }
}
