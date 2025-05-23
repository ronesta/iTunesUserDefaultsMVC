//
//  NetworkManager.swift
//  iTunesUserDefaultsMVC
//
//  Created by Ибрагим Габибли on 29.12.2024.
//

import Foundation

final class ITunesService: ITunesServiceProtocol {
    private var counter = 1

    func loadAlbums(albumName: String, completion: @escaping (Result<[Album], Error>) -> Void) {
        let baseURL = "https://itunes.apple.com/search"
        let term = albumName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "\(baseURL)?term=\(term)&entity=album&attribute=albumTerm"

        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion(.failure(NetworkError.invalidURL))
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error {
                print("Error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }

            guard let data else {
                print("No data")
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.noData))
                }
                return
            }

            do {
                let albums = try JSONDecoder().decode(PostAlbums.self, from: data).results
                DispatchQueue.main.async {
                    completion(.success(albums))
                    print("Load data \(self.counter)")
                    self.counter += 1
                }
            } catch {
                print("Decoding error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
