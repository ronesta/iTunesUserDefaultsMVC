//
//  SearchHistoryViewControllerSnapshotTests.swift
//  iTunesUserDefaultsMVC
//
//  Created by Ибрагим Габибли on 23.04.2025.
//

import XCTest
import SnapshotTesting
@testable import iTunesUserDefaultsMVC

final class SearchHistoryViewControllerSnapshotTests: XCTestCase {
    private var viewController: SearchHistoryViewController!
    private var mockStorageManager: MockStorageManager!
    private var mockDataSource: MockSearchHistoryDataSource!

    override func setUp() {
        super.setUp()
        mockStorageManager = MockStorageManager()
        mockDataSource = MockSearchHistoryDataSource()
        viewController = SearchHistoryViewController(
            storageManager: mockStorageManager,
            tableViewDataSource: mockDataSource
        )
    }

    override func tearDown() {
        viewController = nil
        mockStorageManager = nil
        mockDataSource = nil
        super.tearDown()
    }

    func testDefaultAppearance() {
        let navigationController = UINavigationController(rootViewController: viewController)

        assertSnapshot(of: navigationController, as: .image)
    }

    func testAppearanceWithUpdatedData() {
        let searchHistory = ["Search1", "Search2"]
        let navigationController = UINavigationController(rootViewController: viewController)

        searchHistory.forEach { term in
            mockStorageManager.saveSearchTerm(term)
        }

        viewController.loadViewIfNeeded()
        viewController.updateSearchHistory()
        
        assertSnapshot(of: navigationController, as: .image)
    }
}
