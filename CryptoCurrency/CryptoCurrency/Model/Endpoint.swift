//
//  Endpoint.swift
//  CryptoCurrency
//
//  Created by Hoang Linh Nguyen on 12/9/2023.
//

import Foundation

enum Endpoint: String {
    case coinRankingAPI = "https://api.coinranking.com/v2/coins"
    case coinDetailAPI = "https://api.coinranking.com/v2/coin/"
    case newsAPI = "https://real-time-finance-data.p.rapidapi.com/stock-news?symbol=AAPL%3ANASDAQ&language=en"
}
