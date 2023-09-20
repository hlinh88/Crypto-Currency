//
//  RefreshManager.swift
//  CryptoCurrency
//
//  Created by Hoang Linh Nguyen on 20/9/2023.
//

import UIKit

struct RefreshManager {
    static var shared = RefreshManager()

    private init() {}

    func setupRefreshControl(_ refresh: Selector) -> UIRefreshControl {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: refresh, for: .valueChanged)
        refreshControl.tintColor = UIColor.white
        return refreshControl
    }
}
