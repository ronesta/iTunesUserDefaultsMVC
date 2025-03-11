//
//  SceneDelegate.swift
//  iTunesUserDefaultsMVC
//
//  Created by Ибрагим Габибли on 29.12.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)

        let searchAssembly = SearchAssembly()
        let searchHistoryAssembly = SearchHistoryAssembly()

        let searchNavigationController = searchAssembly.createModule()
        let historyNavigationController = searchHistoryAssembly.createModule()

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [searchNavigationController, historyNavigationController]

        tabBarController.tabBar.barTintColor = .white

        window.rootViewController = tabBarController
        self.window = window
        window.makeKeyAndVisible()
    }
}
