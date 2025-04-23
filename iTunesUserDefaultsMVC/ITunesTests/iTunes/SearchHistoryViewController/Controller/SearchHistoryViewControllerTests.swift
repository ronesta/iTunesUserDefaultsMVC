//
//  SearchHistoryViewControllerTests.swift
//  iTunesUserDefaultsMVC
//
//  Created by Ибрагим Габибли on 23.04.2025.
//

import XCTest
@testable import iTunesUserDefaultsMVC

final class SearchHistoryViewControllerTests: XCTestCase {
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

    func testUpdateSearchHistoryFetchesHistoryAndReloadsTableView() {
        let searchHistory = ["Search1", "Search2"]

        searchHistory.forEach { term in
            mockStorageManager.saveSearchTerm(term)
        }

        viewController.updateSearchHistory()

        XCTAssertEqual(mockDataSource.searchHistory, searchHistory)
    }

    func testPerformSearchOnSelectPushesSearchViewController() {
        let navigationController = UINavigationController(rootViewController: viewController)

        mockDataSource.searchHistory = ["Search1"]
        viewController.loadViewIfNeeded()

        let selectAction = viewController.searchHistoryView.onSelect
        selectAction?(IndexPath(row: 0, section: 0))

        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertTrue(navigationController.topViewController is SearchViewController)
    }
}
