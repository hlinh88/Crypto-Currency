//
//  Coin.swift
//  CryptoCurrency
//
//  Created by Hoang Linh Nguyen on 12/9/2023.
//

import Foundation

struct CoinRanking: Codable {
    var data: CoinRankingItem
}

struct CoinRankingItem: Codable {
    var coins: [Coin]
}

struct CoinDetail: Codable {
    var data: CoinDetailItem
}

struct CoinDetailItem: Codable {
    var coin: Coin
}
