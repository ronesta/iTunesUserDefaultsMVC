//
//  AlbumViewControllerTests.swift
//  iTunesUserDefaultsMVC
//
//  Created by Ибрагим Габибли on 23.04.2025.
//

import XCTest
@testable import iTunesUserDefaultsMVC

final class AlbumViewControllerTests: XCTestCase {
    private var viewController: AlbumViewController!
    private var mockImageLoader: MockImageLoader!
    private var mockAlbum: Album!

    override func setUp() {
        super.setUp()
        mockImageLoader = MockImageLoader()
        mockAlbum = Album(artistId: 111051,
                          artistName: "Eminem",
                          collectionName: "The Eminem Show",
                          artworkUrl100: "url_to_image",
                          collectionPrice: 10.99
        )
        viewController = AlbumViewController(
            album: mockAlbum,
            imageLoader: mockImageLoader
        )
    }

    override func tearDown() {
        mockImageLoader = nil
        mockAlbum = nil
        viewController = nil
        super.tearDown()
    }

    func testAlbumViewController_SetsLabelsAndLoadsImage() {
        let albumView = viewController.view as? AlbumView
        let expectedImage = UIImage(systemName: "checkmark.diamond")

        mockImageLoader.mockImage = expectedImage
        viewController.viewDidLoad()

        waitForAsyncTasksToComplete()

        XCTAssertEqual(albumView?.albumNameLabel.text, mockAlbum.collectionName)
        XCTAssertEqual(albumView?.artistNameLabel.text, mockAlbum.artistName)
        XCTAssertEqual(albumView?.albumImageView.image, expectedImage)
    }

    private func waitForAsyncTasksToComplete() {
        let expectation = expectation(description: "Waiting for async tasks")
        DispatchQueue.main.async {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1.0, handler: nil)
    }
}
