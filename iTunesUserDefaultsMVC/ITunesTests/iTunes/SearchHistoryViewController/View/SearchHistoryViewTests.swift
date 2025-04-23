//
//  SearchHistoryViewTests.swift
//  iTunesUserDefaultsMVC
//
//  Created by Ибрагим Габибли on 23.04.2025.
//

import XCTest
@testable import iTunesUserDefaultsMVC

final class SearchHistoryViewTests: XCTestCase {
    private var searchHistoryView: SearchHistoryView!

    override func setUp() {
        super.setUp()
        searchHistoryView = SearchHistoryView(frame: .zero)
    }

    override func tearDown() {
        searchHistoryView = nil
        super.tearDown()
    }

    func testSetupViews() {
        XCTAssertNotNil(searchHistoryView.tableView)
        XCTAssertNotNil(searchHistoryView.tableView.delegate)
        XCTAssertTrue(searchHistoryView.tableView.delegate === searchHistoryView)
    }

    func testDidSelectRowCallsOnSelectClosure() {
        let indexPath = IndexPath(item: 1, section: 0)
        var calledIndexPath: IndexPath?

        searchHistoryView.onSelect = { indexPath in
            calledIndexPath = indexPath
        }

        searchHistoryView.tableView(searchHistoryView.tableView, didSelectRowAt: indexPath)

        XCTAssertEqual(calledIndexPath, indexPath)
    }
}
