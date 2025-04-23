//
//  SearchViewTests.swift
//  iTunesUserDefaultsMVC
//
//  Created by Ибрагим Габибли on 23.04.2025.
//

import XCTest
@testable import iTunesUserDefaultsMVC

final class SearchViewTests: XCTestCase {
    private var searchView: SearchView!

    override func setUp() {
        super.setUp()
        searchView = SearchView(frame: .zero)
    }

    override func tearDown() {
        searchView = nil
        super.tearDown()
    }

    func testSetupViews() {
        XCTAssertNotNil(searchView.searchBar)
        XCTAssertNotNil(searchView.collectionView.delegate)
        XCTAssertTrue(searchView.collectionView.delegate === searchView)
    }

    func testOnSelectInvokedOnDidSelect() {
        let indexPath = IndexPath(item: 1, section: 0)
        var capturedIndexPath: IndexPath?

        searchView.onSelect = { path in
            capturedIndexPath = path
        }

        searchView.collectionView(searchView.collectionView, didSelectItemAt: indexPath)

        XCTAssertEqual(capturedIndexPath, indexPath)
    }
}
