//
//  AlbumViewTests.swift
//  iTunesUserDefaultsMVC
//
//  Created by Ибрагим Габибли on 23.04.2025.
//

import XCTest
@testable import iTunesUserDefaultsMVC

final class AlbumViewTests: XCTestCase {
    private var albumView: AlbumView! // System Under Test

    override func setUp() {
        super.setUp()
        albumView = AlbumView(frame: .zero)
    }

    override func tearDown() {
        albumView = nil
        super.tearDown()
    }

    func testSetupViews() {
        XCTAssertNotNil(albumView.albumImageView)
        XCTAssertNotNil(albumView.albumNameLabel)
        XCTAssertNotNil(albumView.artistNameLabel)
        XCTAssertNotNil(albumView.collectionPriceLabel)
    }
}
