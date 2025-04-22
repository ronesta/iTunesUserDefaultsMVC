//
//  ITunesServiceProtocol.swift
//  iTunesUserDefaultsMVC
//
//  Created by Ибрагим Габибли on 22.04.2025.
//

import Foundation

protocol ITunesServiceProtocol: AnyObject {
    func loadAlbums(albumName: String, completion: @escaping (Result<[Album], Error>) -> Void)
}
