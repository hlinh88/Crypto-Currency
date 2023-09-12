//
//  ViewController.swift
//  CryptoCurrency
//
//  Created by Hoang Linh Nguyen on 11/9/2023.
//

import UIKit

final class HomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        getCoinRanking()
    }
    private func getCoinRanking() {
        let queue = DispatchQueue(label: "getCoinRankingQueue", qos: .utility)
        queue.async {
            APIManager.shared.fetchCoinRanking(completion: { (coinsList: [Coin]) in
                _ = coinsList.map { coin in }
            }, errorHandler: {
                print("Error fetching API")
            })
        }
    }
}
