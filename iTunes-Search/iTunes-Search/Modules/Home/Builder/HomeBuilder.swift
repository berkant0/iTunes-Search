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
                
        let loadingManager = LoadingManager.shared

        let alertManager = AlertManager.shared
                
        let homeRepository = HomeRepository.getInstance()
                
        let navigationController = UINavigationController(rootViewController: controller)

        controller.viewModel = HomeViewModel(homeRepository: homeRepository, alertManager: alertManager, loadingManager: loadingManager)

        return navigationController
    }
}
