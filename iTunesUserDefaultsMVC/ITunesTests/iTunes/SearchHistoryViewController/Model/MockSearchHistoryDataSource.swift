//
//  MockSearchHistoryDataSource.swift
//  iTunesUserDefaultsMVC
//
//  Created by Ибрагим Габибли on 23.04.2025.
//

import UIKit
@testable import iTunesUserDefaultsMVC

final class MockSearchHistoryDataSource: NSObject, SearchHistoryDataSourceProtocol, UITableViewDataSource {
    var searchHistory = [String]()

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchHistory.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = searchHistory[indexPath.row]
        return cell
    }
}
