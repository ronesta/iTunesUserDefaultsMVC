//
//  AlbumViewController.swift
//  iTunesUserDefaultsMVC
//
//  Created by Ибрагим Габибли on 29.12.2024.
//

import Foundation
import UIKit
import SnapKit

final class AlbumViewController: UIViewController {
    private let imageLoader: ImageLoaderProtocol
    private let album: Album

    private let albumView = AlbumView(frame: .zero)

    init(album: Album, imageLoader: ImageLoaderProtocol) {
        self.album = album
        self.imageLoader = imageLoader
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        view = albumView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAlbum()
    }

    private func setupAlbum() {
        let urlString = album.artworkUrl100
        imageLoader.loadImage(from: urlString) { [weak self] loadedImage in
            DispatchQueue.main.async {
                self?.albumView.albumImageView.image = loadedImage
            }
        }

        albumView.albumNameLabel.text = album.collectionName
        albumView.artistNameLabel.text = album.artistName
        albumView.collectionPriceLabel.text = "\(album.collectionPrice) $"
    }
}
