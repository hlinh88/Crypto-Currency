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
    
    func fetchCoinRanking(completion: @escaping ([Coin]) -> Void, errorHandler: @escaping () -> Void) {
        if let url = URL(string: "\(Endpoint.coinRankingAPI.rawValue)?orderBy=price") {
            var request = URLRequest(url: url)
            request.addValue(Key.apiKey.rawValue, forHTTPHeaderField: "TRN-Api-Key")
            URLSession.shared.dataTask(with: url) { (data, _, _) in
                do {
                    if let postData = data {
                        let decodedData = try JSONDecoder().decode(CoinRanking.self, from: postData)
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
                        let decodedData = try JSONDecoder().decode(CoinDetail.self, from: postData)
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
