//
//  SearchHistoryAssembly.swift
//  iTunesUserDefaultsMVC
//
//  Created by Ибрагим Габибли on 11.03.2025.
//

import Foundation
import UIKit

final class SearchHistoryAssembly {
    func createModule() -> UIViewController {
        let storageManager = StorageManager()

        let tableViewDataSource = SearchHistoryTableViewDataSource()

        let historyViewController = SearchHistoryViewController(
            storageManager: storageManager,
            tableViewDataSource: tableViewDataSource
        )

        let navigationController = UINavigationController(rootViewController: historyViewController)
        let tabBarItem = UITabBarItem(title: "History",
                                      image: UIImage(systemName: "clock"),
                                      tag: 1)
        tabBarItem.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 16)], for: .normal)
        navigationController.tabBarItem = tabBarItem

        return navigationController
    }
}
