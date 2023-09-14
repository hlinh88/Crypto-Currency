//
//  Coin.swift
//  CryptoCurrency
//
//  Created by Hoang Linh Nguyen on 12/9/2023.
//

import Foundation

struct Coin: Codable {
    var uuid: String
    var symbol: String
    var name: String
    var color: String?
    var iconUrl: String
    var price: String
    var change: String
    var description: String?
}
