//
//  SearchHistoryViewController.swift
//  iTunesUserDefaultsMVC
//
//  Created by Ибрагим Габибли on 29.12.2024.
//

import UIKit

final class SearchHistoryViewController: UIViewController {
    lazy var searchHistoryView: SearchHistoryView = {
        let view = SearchHistoryView(frame: .zero)
        view.searchHistoryViewController = self
        return view
    }()

    let searchHistoryTableViewDataSource = SearchHistoryTableViewDataSource()

    override func loadView() {
        super.loadView()
        view = searchHistoryView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }

    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        searchHistoryView.configureTableView(dataSource: searchHistoryTableViewDataSource)
        updateSearchHistory()
    }

    private func setupNavigationBar() {
        title = "History"
    }

    func updateSearchHistory() {
        searchHistoryTableViewDataSource.searchHistory = StorageManager.shared.getSearchHistory()
        searchHistoryView.tableView.reloadData()
    }
}
