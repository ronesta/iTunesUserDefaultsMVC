//
//  AlbumAssembly.swift
//  iTunesUserDefaultsMVC
//
//  Created by Ибрагим Габибли on 11.03.2025.
//

import Foundation
import UIKit

final class AlbumAssembly {
    func createModule(with album: Album) -> UIViewController {
        let storageManager = StorageManager()
        let imageLoader = ImageLoader(storageManager: storageManager)

        let albumViewController = AlbumViewController(album: album, imageLoader: imageLoader)

        return albumViewController
    }
}
