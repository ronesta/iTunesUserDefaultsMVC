//
//  SearchCollectionViewDataSource.swift
//  iTunesUserDefaultsMVC
//
//  Created by Ибрагим Габибли on 07.01.2025.
//

import Foundation
import UIKit

final class SearchCollectionViewDataSource: NSObject, SearchDataSourceProtocol {
    var albums = [Album]()

    private let imageLoader: ImageLoaderProtocol

    init(imageLoader: ImageLoaderProtocol) {
        self.imageLoader = imageLoader
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        albums.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: AlbumCollectionViewCell.id,
            for: indexPath)
                as? AlbumCollectionViewCell else {
            return UICollectionViewCell()
        }

        let album = albums[indexPath.item]

        imageLoader.loadImage(from: album.artworkUrl100) { image in
            DispatchQueue.main.async {
                guard let currentCell = collectionView.cellForItem(at: indexPath) as? AlbumCollectionViewCell else {
                    return
                }

                currentCell.configure(with: album, image: image)
            }
        }

        return cell
    }
}
