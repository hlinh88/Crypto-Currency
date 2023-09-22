//
//  Coin.swift
//  CryptoCurrency
//
//  Created by Hoang Linh Nguyen on 12/9/2023.
//

import Foundation

struct CoinRankingResponse: Codable {
    var data: CoinRankingItem
    var status: String
}

struct CoinRankingItem: Codable {
    var coins: [Coin]
}

struct CoinDetailResponse: Codable {
    var data: CoinDetailItem
}

struct CoinDetailItem: Codable {
    var coin: Coin
}

struct Supply: Codable {
    var total: String
}

struct NewsResponse: Codable {
    var data: NewsItem
}

struct NewsItem: Codable {
    var news: [News]
}

struct News: Codable {
    var articleTitle: String
    var articleUrl: String
    var articlePhotoUrl: String
    var source: String
    var postTimeUtc: String

    enum CodingKeys: String, CodingKey {
        case source
        case articleTitle = "article_title"
        case articleUrl = "article_url"
        case articlePhotoUrl = "article_photo_url"
        case postTimeUtc = "post_time_utc"
    }
}
