//
//  AlbumView.swift
//  iTunesUserDefaultsMVC
//
//  Created by Ибрагим Габибли on 07.01.2025.
//

import Foundation
import UIKit

final class AlbumView: UIView {
    let albumImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 15
        image.clipsToBounds = true
        image.contentMode = .scaleToFill
        image.accessibilityIdentifier = "albumImageView"
        return image
    }()

    let albumNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 3
        label.textAlignment = .center
        label.accessibilityIdentifier = "albumNameLabel"
        return label
    }()

    let artistNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .systemGray
        label.accessibilityIdentifier = "artistNameLabel"
        return label
    }()

    let collectionPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .systemOrange
        label.accessibilityIdentifier = "collectionPriceLabel"
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        addSubview(albumImageView)
        addSubview(albumNameLabel)
        addSubview(artistNameLabel)
        addSubview(collectionPriceLabel)
        backgroundColor = .white

        albumImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(200)
        }

        albumNameLabel.snp.makeConstraints { make in
            make.top.equalTo(albumImageView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.leading.equalTo(albumImageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(10)
        }

        artistNameLabel.snp.makeConstraints { make in
            make.top.equalTo(albumNameLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }

        collectionPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(artistNameLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
    }
}
