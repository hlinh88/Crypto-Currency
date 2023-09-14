//
//  DetailViewController.swift
//  CryptoCurrency
//
//  Created by Hoang Linh Nguyen on 12/9/2023.
//

import UIKit

final class DetailViewController: UIViewController {
    @IBOutlet private weak var coinImageView: UIImageView!
    @IBOutlet private weak var coinNameLabel: UILabel!
    @IBOutlet private weak var coinPriceLabel: UILabel!
    @IBOutlet private weak var coinDesLabel: UILabel!
    @IBOutlet private weak var coinSymbolLabel: UILabel!
    @IBOutlet private weak var backButton: UIButton!

    var uuid: String?
    private var thisCoin: Coin?

    override func viewDidLoad() {
        super.viewDidLoad()
        getCoinDetail()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    private func getCoinDetail() {
        let queue = DispatchQueue(label: "getCoinDetailQueue", qos: .utility)
        queue.async { [unowned self] in
            if let uuid = self.uuid {
                APIManager.shared.fetchCoinDetail(uuid: uuid, completion: { (coin: Coin) in
                    self.thisCoin = Coin(uuid: coin.uuid,
                                         symbol: coin.symbol,
                                         name: coin.name,
                                         color: coin.color,
                                         iconUrl: coin.iconUrl,
                                         price: coin.price,
                                         change: coin.change,
                                         description: coin.description)
                    self.configDetailView()
                }, errorHandler: {
                    self.popUpErrorAlert(message: "Error fetching data")
                })
            }
        }
    }

    private func configDetailView() {
        if let iconURL = thisCoin?.iconUrl {
            ViewManager.shared.setImagePNG(stringURL: iconURL, imageView: coinImageView, viewController: self)
        }
        if let imageColor = thisCoin?.color {
            coinImageView.backgroundColor = imageColor == "#000000"
            ? UIColor.white
            : UIColor.init(hexString: imageColor)
        }
        coinImageView.layer.cornerRadius = 10
        coinNameLabel.text = thisCoin?.name
        coinSymbolLabel.text = thisCoin?.symbol
        if let price = thisCoin?.price {
            if let decimal = Double(price) {
                coinPriceLabel.text = "$\(String(format: "%.2f", decimal))"
            }
        }
        coinDesLabel.text = thisCoin?.description
    }

    @IBAction func handleBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
