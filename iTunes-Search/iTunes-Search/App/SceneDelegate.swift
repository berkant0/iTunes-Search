//
//  SceneDelegate.swift
//  iTunes-Search
//
//  Created by Berkant Dağtekin on 29.07.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    // MARK: Properties
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let homeController = HomeViewController()

        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = homeController
        window?.makeKeyAndVisible()
    }
}
