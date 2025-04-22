//
//  SearchHistoryDataSourceProtocol.swift
//  iTunesUserDefaultsMVC
//
//  Created by Ибрагим Габибли on 22.04.2025.
//

import Foundation
import UIKit

protocol SearchHistoryDataSourceProtocol: AnyObject, UITableViewDataSource {
    var searchHistory: [String] { get set }
}
