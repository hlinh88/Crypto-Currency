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
    var marketCap: String?
    var volume24h: String?
    var supply: Supply?
    var sparkline: [String?]?
    var websiteUrl: String?

    enum CodingKeys: String, CodingKey {
        case uuid, symbol, name, color, iconUrl, price, change, description, marketCap, supply, sparkline, websiteUrl
        case volume24h = "24hVolume"
    }
}
