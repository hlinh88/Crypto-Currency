//
//  APIManager.swift
//  CryptoCurrency
//
//  Created by Hoang Linh Nguyen on 12/9/2023.
//

import UIKit

final class APIManager {
    static let shared = APIManager()

    private init() {}

    func fetchCoinRanking(orderBy: String, completion: @escaping ([Coin]) -> Void, errorHandler: @escaping () -> Void) {
        if let url = URL(string: "\(Endpoint.coinRankingAPI.rawValue)?orderBy=\(orderBy)") {
            var request = URLRequest(url: url)
            request.addValue(Key.apiKey.rawValue, forHTTPHeaderField: "TRN-Api-Key")
            URLSession.shared.dataTask(with: url) { (data, _, _) in
                do {
                    if let postData = data {
                        let decodedData = try JSONDecoder().decode(CoinRankingResponse.self, from: postData)
                        DispatchQueue.main.async {
                            completion(decodedData.data.coins)
                        }
                    } else {
                        errorHandler()
                    }
                } catch {
                    errorHandler()
                }
            }.resume()
        }
    }

    func fetchCoinDetail(uuid: String, completion: @escaping (Coin) -> Void, errorHandler: @escaping () -> Void) {
        if let url = URL(string: "\(Endpoint.coinDetailAPI.rawValue)\(uuid)") {
            var request = URLRequest(url: url)
            request.addValue(Key.apiKey.rawValue, forHTTPHeaderField: "TRN-Api-Key")
            URLSession.shared.dataTask(with: url) { (data, _, _) in
                do {
                    if let postData = data {
                        let decodedData = try JSONDecoder().decode(CoinDetailResponse.self, from: postData)
                        DispatchQueue.main.async {
                            completion(decodedData.data.coin)
                        }
                    } else {
                        errorHandler()
                    }
                } catch {
                    errorHandler()
                }
            }.resume()
        }
    }

    func fetchNews(completion: @escaping ([News]) -> Void, errorHandler: @escaping () -> Void) {
        let headers = [
            "X-RapidAPI-Key": Key.newsAPIKey.rawValue,
            "X-RapidAPI-Host": Key.newsHost.rawValue
        ]
        if let url = NSURL(string: Endpoint.newsAPI.rawValue) {
            let request = NSMutableURLRequest(url: url as URL,
                                                    cachePolicy: .useProtocolCachePolicy,
                                                timeoutInterval: 10.0)
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = headers
            URLSession.shared.dataTask(with: request as URLRequest) { (data, _, _) in
                do {
                    if let postData = data {
                        let decodedData = try JSONDecoder().decode(NewsResponse.self, from: postData)
                        DispatchQueue.main.async {
                            completion(decodedData.data.news)
                        }
                    } else {
                        errorHandler()
                    }
                } catch {
                    errorHandler()
                }
            }.resume()
        }
    }

    func getImageData(stringURL: String, completion: @escaping (Data) -> Void, errorHandler: @escaping () -> Void) {
        if let url = URL(string: stringURL) {
            URLSession.shared.dataTask(with: url) { data, _, error in
                if let data = data, error == nil {
                    DispatchQueue.main.async {
                        completion(data)
                    }
                } else {
                    errorHandler()
                }
            }.resume()
        }
    }
}
