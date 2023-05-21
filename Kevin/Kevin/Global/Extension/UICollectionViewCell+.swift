//
//  UICollectionViewCell+.swift
//  Kevin
//
//  Created by heerucan on 2023/05/02.
//

import UIKit

extension UICollectionViewCell {
    static func register(_ target: UICollectionView) {
        target.register(Self.self, forCellWithReuseIdentifier: Self.identifier)
    }
}

extension UITableViewCell {
    static func register(_ target: UITableView) {
        target.register(Self.self, forCellReuseIdentifier:Self.identifier)
    }
}
