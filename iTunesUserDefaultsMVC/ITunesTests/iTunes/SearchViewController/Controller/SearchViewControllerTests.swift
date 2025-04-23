//
//  SearchViewControllerTests.swift
//  iTunesUserDefaultsMVC
//
//  Created by Ибрагим Габибли on 23.04.2025.
//

import XCTest
import ViewControllerPresentationSpy
@testable import iTunesUserDefaultsMVC

final class SearchViewControllerTests: XCTestCase {
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

    func testSearchButtonClickedSavesSearchTerm() {
        let term = "SomeAlbum"

        viewController.searchView.searchBar.text = term
        viewController.searchBarSearchButtonClicked(viewController.searchView.searchBar)

        XCTAssertTrue(mockStorageManager.searchHistory.contains(term))
    }

    func testSearchAlbumsWithSavedAlbums() {
        let term = "SavedAlbums"

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

        mockStorageManager.saveAlbums(albums, for: term)
        viewController.searchAlbums(with: term)

        let savedAlbums = mockStorageManager.loadAlbums(for: term)
        XCTAssertEqual(savedAlbums, albums)

        XCTAssertEqual(mockDataSource.albums, albums)
    }

    func testSearchAlbumsWithNewAlbums() {
        let term = "Eminem"

        let albums = [
            Album(artistId: 111051,
                  artistName: "Eminem",
                  collectionName: "The Eminem Show",
                  artworkUrl100: "url_to_image",
                  collectionPrice: 10.99
                 )
        ]

        mockITunesService.albums = albums
        viewController.searchAlbums(with: term)

        XCTAssertEqual(mockDataSource.albums, albums)
    }

    @MainActor func testSearchAlbumsWithServiceErrorShowsAlert() {
        let errorMessage = "Test Error"
        let alertVerifier = AlertVerifier()

        viewController.showError(errorMessage)

        alertVerifier.verify(
            title: "Error",
            message: "Test Error",
            animated: true,
            actions: [
                .default("OK")
            ],
            presentingViewController: viewController
        )
    }
}
