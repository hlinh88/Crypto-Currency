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
    @IBOutlet private weak var followButton: UIButton!
    @IBOutlet private weak var marketCapLabel: UILabel!
    @IBOutlet private weak var volume24hLabel: UILabel!
    @IBOutlet private weak var supplyLabel: UILabel!
    @IBOutlet private weak var changeRateLabel: UILabel!

    var uuid: String?
    private var thisCoin: Coin?

    override func viewDidLoad() {
        super.viewDidLoad()
        getCoinDetail()
        customizeView()
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
                                         description: coin.description,
                                         marketCap: coin.marketCap,
                                         volume24h: coin.volume24h,
                                         supply: coin.supply)
                    self.configDetailView()
                }, errorHandler: {
                    self.popUpErrorAlert(message: "Error fetching data")
                })
            }
        }
    }

    private func customizeView() {
        coinImageView.layer.cornerRadius = LayerSettings.radius.rawValue
        followButton.layer.cornerRadius = LayerSettings.radius.rawValue
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
        coinNameLabel.text = thisCoin?.name
        coinSymbolLabel.text = thisCoin?.symbol
        if let price = thisCoin?.price {
            if let decimal = Double(price) {
                coinPriceLabel.text = "$\(String(format: "%.2f", decimal))"
            }
        }
        coinDesLabel.text = thisCoin?.description
        if let marketCap = thisCoin?.marketCap,
           let volume24h = thisCoin?.volume24h,
           let supplyTotal = thisCoin?.supply?.total {
            if let marketCapValue = Double(marketCap),
               let volume24hValue = Double(volume24h),
               let supplyTotalValue = Double(supplyTotal) {
                marketCapLabel.text = "$\(marketCapValue.formatted())"
                volume24hLabel.text = "$\(volume24hValue.formatted())"
                supplyLabel.text = supplyTotalValue.formatted()
                }
            }

        if let changeRate = thisCoin?.change {
            let isChanged = ViewManager.shared.checkChangeRate(rate: changeRate)
            changeRateLabel.text = "\(changeRate)%"
            changeRateLabel.textColor = isChanged ? .systemGreen : .systemRed
        }
    }

    @IBAction func handleBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
