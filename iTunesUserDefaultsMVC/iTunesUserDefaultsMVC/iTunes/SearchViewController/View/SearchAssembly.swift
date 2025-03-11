//
//  SearchAssembly.swift
//  iTunesUserDefaultsMVC
//
//  Created by Ибрагим Габибли on 11.03.2025.
//

import Foundation
import UIKit

final class SearchAssembly {
    func createModule() -> UIViewController {
        let storageManager = StorageManager()
        let itunesService = ItunesService()
        let imageLoader = ImageLoader(storageManager: storageManager)

        let collectionViewDataSource = SearchCollectionViewDataSource(imageLoader: imageLoader)

        let searchViewController = SearchViewController(
            itunesService: itunesService,
            storageManager: storageManager,
            collectionViewDataSource: collectionViewDataSource
        )

        let navigationController = UINavigationController(rootViewController: searchViewController)
        let tabBarItem = UITabBarItem(title: "Search",
                                      image: UIImage(systemName: "magnifyingglass"),
                                      tag: 0)
        tabBarItem.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 16)], for: .normal)
        navigationController.tabBarItem = tabBarItem

        return navigationController
    }
}
