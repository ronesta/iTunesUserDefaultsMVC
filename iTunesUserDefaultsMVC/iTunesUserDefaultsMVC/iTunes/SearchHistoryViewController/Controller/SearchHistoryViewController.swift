//
//  SearchHistoryViewController.swift
//  iTunesUserDefaultsMVC
//
//  Created by Ибрагим Габибли on 29.12.2024.
//

import UIKit

final class SearchHistoryViewController: UIViewController {
    private lazy var searchHistoryView: SearchHistoryView = {
        let view = SearchHistoryView(frame: .zero)
        view.tableView.dataSource = tableViewDataSource
        return view
    }()

    private let storageManager: StorageManager
    private let tableViewDataSource: SearchHistoryTableViewDataSource

    init(storageManager: StorageManager,
         tableViewDataSource: SearchHistoryTableViewDataSource) {
        self.storageManager = storageManager
        self.tableViewDataSource = tableViewDataSource
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        view = searchHistoryView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        performSearch()
    }

    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        updateSearchHistory()
    }

    private func setupNavigationBar() {
        title = "History"
    }

    func updateSearchHistory() {
        tableViewDataSource.searchHistory = storageManager.getSearchHistory()
        searchHistoryView.tableView.reloadData()
    }

    private func performSearch() {
        searchHistoryView.onSelect = { [weak self] indexPath in
            guard let selectedTerm = self?.tableViewDataSource.searchHistory[indexPath.row] else {
                return
            }

            let searchAssembly = SearchAssembly()

            guard let searchViewController = searchAssembly.createModule() as? UINavigationController,
                  let rootViewController = searchViewController.viewControllers.first as? SearchViewController else {
                return
            }

            rootViewController.searchView.searchBar.isHidden = true
            rootViewController.searchAlbums(with: selectedTerm)

            self?.navigationController?.pushViewController(rootViewController, animated: true)
        }
    }
}
