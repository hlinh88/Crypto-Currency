//
//  ExchangeViewController.swift
//  CryptoCurrency
//
//  Created by Hoang Linh Nguyen on 12/9/2023.
//

import UIKit

final class ExchangeViewController: UIViewController {

    @IBOutlet private weak var coinView: UIView!
    @IBOutlet private weak var coinImageView: UIImageView!
    @IBOutlet private weak var coinNameLabel: UILabel!
    @IBOutlet private weak var coinSymbolLabel: UILabel!
    @IBOutlet weak var coinTextField: UITextField!
    @IBOutlet private weak var moneyView: UIView!
    @IBOutlet private weak var moneyNameLabel: UILabel!
    @IBOutlet private weak var moneySymbolLabel: UILabel!
    @IBOutlet private weak var moneyImageView: UIImageView!
    @IBOutlet private weak var moneyPriceLabel: UILabel!
    @IBOutlet weak var exchangeButton: UIButton!

    private var currentCoinRate = 0.0
    private var currentMoneyRate = 0.0
    private var coinText = String.isEmpty

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        self.hideKeyboardWhenTappedAround()
    }

    func setCurrentCoinRate(rate: Double) {
        self.currentCoinRate = rate
    }

    func setCurrentMoneyRate(rate: Double) {
        self.currentMoneyRate = rate
    }

    private func configView() {
        coinView.layer.cornerRadius = LayerSettings.radius.rawValue
        moneyView.layer.cornerRadius = LayerSettings.radius.rawValue
        exchangeButton.layer.cornerRadius = LayerSettings.radius.rawValue
        coinImageView.layer.cornerRadius = LayerSettings.radius.rawValue
        moneyImageView.layer.cornerRadius = LayerSettings.radius.rawValue
        coinView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                  action: #selector(coinViewHandler)))
        moneyView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                              action: #selector(moneyViewHandler)))
    }

    @objc private func coinViewHandler() {
        let coinVC = CoinsViewController()
        coinVC.configStatus(isConvertedCoin: true)
        coinVC.delegate = self
        if let sheet = coinVC.sheetPresentationController {
            sheet.detents = [.large()]
            sheet.preferredCornerRadius = LayerSettings.radius.rawValue
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
        }
        self.present(coinVC, animated: true)
    }

    @objc func moneyViewHandler() {
        let coinVC = CoinsViewController()
        coinVC.configStatus(isConvertedCoin: false)
        coinVC.delegate = self
        if let sheet = coinVC.sheetPresentationController {
            sheet.detents = [.large()]
            sheet.preferredCornerRadius = LayerSettings.radius.rawValue
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
        }
        self.present(coinVC, animated: true)
    }

    @IBAction func handleTextFieldChanged(_ sender: UITextField) {
        if let text = sender.text {
            self.coinText = text
        }
    }

    @IBAction func handleExchangeButton(_ sender: UIButton) {
        if currentCoinRate == 0.0 || currentMoneyRate == 0.0 || coinText == String.isEmpty {
            self.popUpErrorAlert(message: "Please select a coin or input coin amount")
        } else {
            if let coinValue = Double(coinText) {
                let convertedResult = currentCoinRate * coinValue / currentMoneyRate
                let formattedResult = String(format: "%.2f", convertedResult)
                moneyPriceLabel.text = formattedResult
            }
        }
    }
}

extension ExchangeViewController: CoinsViewControllerDelegate {
    func cellSelected(coin: Coin, isConvertedCoin: Bool) {
        if let imageColor = coin.color {
            isConvertedCoin ?
            (self.coinImageView.backgroundColor = imageColor == String.blackColor
            ? UIColor.white
            : UIColor.init(hexString: imageColor))
            : (self.moneyImageView.backgroundColor = imageColor == String.blackColor
            ? UIColor.white
            : UIColor.init(hexString: imageColor))
        }
        ViewManager.shared.setImagePNG(stringURL: coin.iconUrl,
                                       imageView: isConvertedCoin ? coinImageView : moneyImageView,
                                       viewController: ExchangeViewController())
        isConvertedCoin ? (self.coinNameLabel.text = coin.name) : (self.moneyNameLabel.text = coin.name)

        if isConvertedCoin {
            if let coinRate = Double(coin.price) {
                self.currentCoinRate = coinRate
                self.coinSymbolLabel.text = "1 \(coin.symbol) = $\(String(format: "%.2f", coinRate))"
            }
        } else {
            if let coinRate = Double(coin.price) {
                self.currentMoneyRate = coinRate
                self.moneySymbolLabel.text =  "1 \(coin.symbol) = $ \(String(format: "%.2f", coinRate))"
            }
        }
    }
}
