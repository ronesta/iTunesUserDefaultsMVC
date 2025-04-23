//
//  SearchViewControllerSnapshotTests.swift
//  iTunesUserDefaultsMVC
//
//  Created by Ибрагим Габибли on 23.04.2025.
//

import XCTest
import SnapshotTesting
@testable import iTunesUserDefaultsMVC

final class SearchViewControllerSnapshotTests: XCTestCase {
    private var viewController: SearchViewController!
    private var mockITunesService: MockITunesServiceForController!
    private var mockStorageManager: MockStorageManager!
    private var mockDataSource: MockSearchDataSource!

    override func setUp() {
        super.setUp()
        mockITunesService = MockITunesServiceForController()
        mockStorageManager = MockStorageManager()
        mockDataSource = MockSearchDataSource()
        viewController = SearchViewController(
            itunesService: mockITunesService,
            storageManager: mockStorageManager,
            collectionViewDataSource: mockDataSource
        )
    }

    override func tearDown() {
        mockITunesService = nil
        mockStorageManager = nil
        mockDataSource = nil
        viewController = nil
        super.tearDown()
    }

    func testSearchViewControllerInitialAppearance() {
        let navigationController = UINavigationController(rootViewController: viewController)

        assertSnapshot(of: navigationController, as: .image)
    }

    func testSearchViewControllerWithAlbums() {
        let term = "Eminem"

        let albums = [
            Album(artistId: 111051,
                  artistName: "Eminem",
                  collectionName: "The Eminem Show",
                  artworkUrl100: "url_to_image",
                  collectionPrice: 10.99
                 ),
            Album(artistId: 20044,
                  artistName: "Eminem",
                  collectionName: "Levitating",
                  artworkUrl100: "url_to_image",
                  collectionPrice: 9.99
                 )
        ]
    
        let navigationController = UINavigationController(rootViewController: viewController)

        viewController.loadViewIfNeeded()
        mockITunesService.albums = albums
        mockStorageManager.saveAlbums(albums, for: term)
        viewController.searchAlbums(with: term)

        assertSnapshot(of: navigationController, as: .image)
    }
}
