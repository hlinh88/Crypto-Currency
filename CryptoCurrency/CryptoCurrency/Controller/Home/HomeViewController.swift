//
//  ViewController.swift
//  CryptoCurrency
//
//  Created by Hoang Linh Nguyen on 11/9/2023.
//

import UIKit

final class HomeViewController: UIViewController {
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var popUpButton: UIButton!
    @IBOutlet private weak var stockTableView: UITableView!

    private var coins = [Coin]()

    override func viewDidLoad() {
        super.viewDidLoad()
        getCoinRanking()
        customizeView()
        registerTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    private func getCoinRanking() {
        let queue = DispatchQueue(label: "getCoinRankingQueue", qos: .utility)
        queue.async { [unowned self] in
            APIManager.shared.fetchCoinRanking(completion: { (coinsList: [Coin]) in
                _ = coinsList.map { coin in
                    self.coins.append(Coin(uuid: coin.uuid,
                                           symbol: coin.symbol,
                                           name: coin.name,
                                           color: coin.color,
                                           iconUrl: coin.iconUrl,
                                           price: coin.price,
                                           change: coin.change))
                }
                self.stockTableView.reloadData()
            }, errorHandler: {
                self.popUpErrorAlert(message: "Error fetching API")
            })
        }
    }

    private func customizeView() {
        setupPopUpButton()
        searchBar.customizeSearchBar()
    }

    private func registerTableView() {
        stockTableView.register(UINib(nibName: "StockViewCell", bundle: nil), forCellReuseIdentifier: "stockCellId")
        stockTableView.delegate = self
        stockTableView.dataSource = self
    }

    private func setupPopUpButton() {
        let popUpButtonAction = { (_: UIAction) in
            //TODO: Update later
        }

        popUpButton.menu = UIMenu(children: [
            UIAction(title: "Top Ranking", handler: popUpButtonAction),
            UIAction(title: "Top Change", handler: popUpButtonAction),
            UIAction(title: "Top 24h Market", handler: popUpButtonAction),
            UIAction(title: "Top Market Cap", handler: popUpButtonAction)
        ])
        popUpButton.customizePopUpButton()
        popUpButton.showsMenuAsPrimaryAction = true
        popUpButton.changesSelectionAsPrimaryAction = true
    }

}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coins.count
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = stockTableView.dequeueReusableCell(withIdentifier: "stockCellId", for: indexPath)
            as? StockViewCell {
            cell.configStock(ranking: (indexPath.row + 1), thisCoin: coins[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.uuid = coins[indexPath.row].uuid
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
