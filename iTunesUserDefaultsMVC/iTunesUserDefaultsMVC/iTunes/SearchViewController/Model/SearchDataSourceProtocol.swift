//
//  SearchDataSourceProtocol.swift
//  iTunesUserDefaultsMVC
//
//  Created by Ибрагим Габибли on 22.04.2025.
//

import Foundation
import UIKit

protocol SearchDataSourceProtocol: AnyObject, UICollectionViewDataSource {
    var albums: [Album] { get set }
}
