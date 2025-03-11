//
//  SearchHistoryView.swift
//  iTunesUserDefaultsMVC
//
//  Created by Ибрагим Габибли on 07.01.2025.
//

import Foundation
import UIKit

final class SearchHistoryView: UIView {
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .singleLine
        return tableView
    }()

    var onSelect: ((IndexPath) -> Void)?
    static let id = "cell"

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        backgroundColor = .systemGray6
        addSubview(tableView)

        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: SearchHistoryView.id)

        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDelegate
extension SearchHistoryView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        onSelect?(indexPath)
    }
}
