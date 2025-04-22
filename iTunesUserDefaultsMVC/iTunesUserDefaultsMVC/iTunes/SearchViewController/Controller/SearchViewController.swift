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
        view.collectionView.dataSource = collectionViewDataSource
        view.searchBar.delegate = self
        return view
    }()

    private let itunesService: ITunesServiceProtocol
    private let storageManager: StorageManagerProtocol
    private let collectionViewDataSource: SearchDataSourceProtocol

    init(itunesService: ITunesServiceProtocol,
         storageManager: StorageManagerProtocol,
         collectionViewDataSource: SearchDataSourceProtocol) {
        self.itunesService = itunesService
        self.storageManager = storageManager
        self.collectionViewDataSource = collectionViewDataSource
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        view = searchView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        displayAlbumDetails()
    }

    private func setupNavigationBar() {
        navigationItem.titleView = searchView.searchBar
    }

    private func saveSearchTerm(_ term: String) {
        storageManager.saveSearchTerm(term)
    }

    private func didTypeSearch(_ searchQuery: String) {
        guard !searchQuery.isEmpty else {
            return
        }

        searchAlbums(with: searchQuery)
    }

    func searchAlbums(with term: String) {
        if let savedAlbums = storageManager.loadAlbums(for: term) {
            collectionViewDataSource.albums = savedAlbums
            searchView.collectionView.reloadData()
            return
        }

        itunesService.loadAlbums(albumName: term) { [weak self] result in
            switch result {
            case .success(let albums):
                self?.collectionViewDataSource.albums = albums.sorted {
                    $0.collectionName < $1.collectionName
                }
                self?.searchView.collectionView.reloadData()
                self?.storageManager.saveAlbums(albums, for: term)
                print("Successfully loaded \(albums.count) albums.")
            case .failure(let error):
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self?.present(alert, animated: true)
                print("Failed to load images with error: \(error.localizedDescription)")
            }
        }
    }

    private func displayAlbumDetails() {
        searchView.onSelect = { [weak self] indexPath in
            guard let album = self?.collectionViewDataSource.albums[indexPath.item] else {
                return
            }

            let albumAssembly = AlbumAssembly()

            let albumViewController = albumAssembly.createModule(with: album)

            self?.navigationController?.pushViewController(albumViewController, animated: true)
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

        searchAlbums(with: searchTerm)
        saveSearchTerm(searchTerm)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        didTypeSearch(searchText)
    }
}
