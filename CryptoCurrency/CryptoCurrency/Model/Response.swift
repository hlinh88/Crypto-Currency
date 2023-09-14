//
//  Coin.swift
//  CryptoCurrency
//
//  Created by Hoang Linh Nguyen on 12/9/2023.
//

import Foundation

struct Item: Codable {
    var coins: [Coin]
}

struct Response: Codable {
    var data: Item
}
