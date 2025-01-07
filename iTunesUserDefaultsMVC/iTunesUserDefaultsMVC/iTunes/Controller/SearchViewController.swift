//
//  ViewController.swift
//  iTunesUserDefaultsMVC
//
//  Created by Ибрагим Габибли on 29.12.2024.
//

import UIKit
import SnapKit

final class SearchViewController: UIViewController {
    lazy var searchView: SearchView = {
        let view = SearchView(frame: .zero)
        view.searchViewController = self
        return view
    }()

    let searchCollectionViewDataSource = SearchCollectionViewDataSource()

    override func loadView() {
        super.loadView()
        view = searchView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }

    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        searchView.configureCollectionView(dataSource: searchCollectionViewDataSource)
        searchView.configureSearchBar(delegate: self)
    }

    private func setupNavigationBar() {
        navigationItem.titleView = searchView.searchBar
    }

    func searchAlbums(with term: String) {
        if let savedAlbums = StorageManager.shared.loadAlbums(for: term) {
            searchCollectionViewDataSource.albums = savedAlbums
            searchView.collectionView.reloadData()
            return
        }

        NetworkManager.shared.fetchAlbums(albumName: term) { [weak self] result in
            switch result {
            case .success(let albums):
                DispatchQueue.main.async {
                    self?.searchCollectionViewDataSource.albums = albums.sorted {
                        $0.collectionName < $1.collectionName
                    }
                    self?.searchView.collectionView.reloadData()
                    StorageManager.shared.saveAlbums(albums, for: term)
                    print("Successfully loaded \(albums.count) albums.")
                }
            case .failure(let error):
                print("Failed to load images with error: \(error.localizedDescription)")
            }
        }
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else {
            return
        }
        StorageManager.shared.saveSearchTerm(searchTerm)
        searchAlbums(with: searchTerm)
    }
}
