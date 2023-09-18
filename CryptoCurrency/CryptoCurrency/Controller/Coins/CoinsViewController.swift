//
//  CoinsViewController.swift
//  CryptoCurrency
//
//  Created by Hoang Linh Nguyen on 18/9/2023.
//

import UIKit

protocol CoinsViewControllerDelegate: AnyObject {
    func cellSelected(coin: Coin, isConvertedCoin: Bool)
}

final class CoinsViewController: UIViewController {
    @IBOutlet private weak var coinsTableView: UITableView!

    private var coinList = [Coin]()
    private var isConvertedCoin: Bool?
    weak var delegate: CoinsViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableView()
        getCoinList()
    }

    func configStatus(isConvertedCoin: Bool) {
        self.isConvertedCoin = isConvertedCoin
    }

    private func getCoinList() {
        let orderBy = "price"
        let queue = DispatchQueue(label: "getCoinRankingQueue", qos: .utility)
        queue.async { [unowned self] in
            APIManager.shared.fetchCoinRanking(orderBy: orderBy, completion: { (coinsList: [Coin]) in
                _ = coinsList.map { coin in
                    self.coinList.append(Coin(uuid: coin.uuid,
                                           symbol: coin.symbol,
                                           name: coin.name,
                                           color: coin.color,
                                           iconUrl: coin.iconUrl,
                                           price: coin.price,
                                           change: coin.change))
                }
                self.coinsTableView.reloadData()
            }, errorHandler: {
                self.popUpErrorAlert(message: "Error fetching API")
            })
        }
    }

    private func registerTableView() {
        coinsTableView.register(UINib(nibName: "CoinsViewCell", bundle: nil), forCellReuseIdentifier: "coinsCellId")
        coinsTableView.delegate = self
        coinsTableView.dataSource = self
    }
}

extension CoinsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coinList.count
    }
}

extension CoinsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = coinsTableView.dequeueReusableCell(withIdentifier: "coinsCellId", for: indexPath)
            as? CoinsViewCell {
            cell.configCoinCell(thisCoin: coinList[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let isConvertedCoin = self.isConvertedCoin {
            delegate?.cellSelected(coin: coinList[indexPath.row], isConvertedCoin: isConvertedCoin)
            dismiss(animated: true)
        }
    }
}
