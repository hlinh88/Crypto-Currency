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

    override func viewDidLoad() {
        super.viewDidLoad()
        getCoinRanking()
        customizeView()
        stockTableView.register(UINib(nibName: "StockViewCell", bundle: nil), forCellReuseIdentifier: "stockCellId")
        stockTableView.delegate = self
        stockTableView.dataSource = self
    }

    private func getCoinRanking() {
        let queue = DispatchQueue(label: "getCoinRankingQueue", qos: .utility)
        queue.async {
            APIManager.shared.fetchCoinRanking(completion: { (coinsList: [Coin]) in
                _ = coinsList.map { _ in }
            }, errorHandler: {
                self.popUpErrorAlert(message: "Error fetching API")
            })
        }
    }

    private func customizeView() {
        setupPopUpButton()
        searchBar.customizeSearchBar()
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

    private func popUpErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Done", style: UIAlertAction.Style.default, handler: nil))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sampleRows = 10
        return sampleRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = stockTableView.dequeueReusableCell(withIdentifier: "stockCellId", for: indexPath)
            as? StockViewCell {
            return cell
        }
        return UITableViewCell()
    }
}
