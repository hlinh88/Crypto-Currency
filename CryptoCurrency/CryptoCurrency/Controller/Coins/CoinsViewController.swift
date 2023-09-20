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
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var coinsTableView: UITableView!
    
    private var coinList = [Coin]()
    private var searchCoinList = [Coin]()
    private var isConvertedCoin: Bool?
    private var isSearching = false
    weak var delegate: CoinsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableView()
        getCoinList()
        customizeView()
    }

    private func customizeView() {
        coinsTableView.keyboardDismissMode = .onDrag
        searchBar.searchTextField.textColor = UIColor.white
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
        if isSearching { return searchCoinList.count } else { return coinList.count }
    }
}

extension CoinsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = coinsTableView.dequeueReusableCell(withIdentifier: "coinsCellId", for: indexPath)
            as? CoinsViewCell {
            isSearching
            ? cell.configCoinCell(thisCoin: searchCoinList[indexPath.row])
            : cell.configCoinCell(thisCoin: coinList[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let isConvertedCoin = self.isConvertedCoin {
            delegate?.cellSelected(coin: isSearching ? searchCoinList[indexPath.row] : coinList[indexPath.row], isConvertedCoin: isConvertedCoin)
            dismiss(animated: true)
        }
    }
}

extension CoinsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchCoinList = coinList.filter({ $0.name.lowercased().prefix(searchText.count) == searchText.lowercased() })
        isSearching = true
        coinsTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
