//
//  ViewController.swift
//  CryptoCurrency
//
//  Created by Hoang Linh Nguyen on 11/9/2023.
//

import UIKit

final class HomeViewController: UIViewController {
    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet private weak var popUpButton: UIButton!
    @IBOutlet private weak var stockTableView: UITableView!

    private var coins = [Coin]()
    private var searchCoins = [Coin]()
    private var isSearching = false
    private var categoryId = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        getCoinRanking(categoryId: categoryId)
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

    private func getCoinRanking(categoryId: Int) {
        let orderBy = matchIdWithOrderBy(categoryId: categoryId)
        let queue = DispatchQueue(label: "getCoinRankingQueue", qos: .utility)
        queue.async { [unowned self] in
            APIManager.shared.fetchCoinRanking(orderBy: orderBy, completion: { (coinsList: [Coin]) in
                self.coins = []
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
        searchTextField.customizeSearch()
    }

    private func registerTableView() {
        stockTableView.register(UINib(nibName: "StockViewCell", bundle: nil), forCellReuseIdentifier: "stockCellId")
        stockTableView.delegate = self
        stockTableView.dataSource = self
    }

    private func setupPopUpButton() {
        func popUpButtonAction(id: Int) {
            self.categoryId = id
            getCoinRanking(categoryId: categoryId)
        }

        popUpButton.menu = UIMenu(children: [
            UIAction(title: "Top Price") { _ in
                popUpButtonAction(id: self.getCategoryId(categoryName: "price"))
            },
            UIAction(title: "Top Market Cap") { _ in
                popUpButtonAction(id: self.getCategoryId(categoryName: "marketCap"))
            },
            UIAction(title: "Top 24h Volume") { _ in
                popUpButtonAction(id: self.getCategoryId(categoryName: "volume"))
            },
            UIAction(title: "Top Change") { _ in
                popUpButtonAction(id: self.getCategoryId(categoryName: "change"))
            }
        ])
        popUpButton.customizePopUpButton()
        popUpButton.showsMenuAsPrimaryAction = true
        popUpButton.changesSelectionAsPrimaryAction = true
    }

    private func getCategoryId(categoryName: String) -> Int {
        switch categoryName {
        case "marketCap":
            return 1
        case "volume":
            return 2
        case "change":
            return 3
        default:
            return 0
        }
    }

    private func matchIdWithOrderBy(categoryId: Int) -> String {
        switch categoryId {
        case 1:
            return "marketCap"
        case 2:
            return "24hVolume"
        case 3:
            return "change"
        default:
            return "price"
        }
    }

    @IBAction private func searchHandler(_ sender: UITextField) {
        if let searchText = sender.text {
            searchCoins = coins.filter({ $0.name.lowercased().prefix(searchText.count) == searchText.lowercased() })
            isSearching = searchText == String.isEmpty ? false : true
            stockTableView.reloadData()
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching { return searchCoins.count } else { return coins.count }
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = stockTableView.dequeueReusableCell(withIdentifier: "stockCellId", for: indexPath)
            as? StockViewCell {
            isSearching
            ? cell.configStock(ranking: (indexPath.row + 1), thisCoin: searchCoins[indexPath.row])
            :  cell.configStock(ranking: (indexPath.row + 1), thisCoin: coins[indexPath.row])
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

extension HomeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
