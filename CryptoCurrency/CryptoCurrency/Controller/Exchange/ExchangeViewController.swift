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
    @IBOutlet private weak var moneyView: UIView!
    @IBOutlet private weak var coinButton: UIButton!
    @IBOutlet private weak var moneyImageView: UIImageView!
    @IBOutlet private weak var exchangeButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }

    private func configView() {
        coinView.layer.cornerRadius = LayerSettings.radius.rawValue
        moneyView.layer.cornerRadius = LayerSettings.radius.rawValue
        exchangeButton.roundButton()
        coinImageView.roundCorner()
        moneyImageView.roundCorner()
        coinButton.contentEdgeInsets = UIEdgeInsets(top: LayerSettings.edgeInsets.rawValue,
                                                    left: LayerSettings.edgeInsets.rawValue,
                                                    bottom: LayerSettings.edgeInsets.rawValue,
                                                    right: LayerSettings.edgeInsets.rawValue)
        setupCoinButton()
    }

    private func setupCoinButton() {
        let popUpButtonAction = { (_: UIAction) in
            //TODO: Update later
        }

        coinButton.menu = UIMenu(children: [
            UIAction(title: "Bitcoin", handler: popUpButtonAction),
            UIAction(title: "Ethereum", handler: popUpButtonAction),
            UIAction(title: "Quant", handler: popUpButtonAction),
            UIAction(title: "Vinfast", handler: popUpButtonAction)
        ])
        coinButton.customizePopUpButton()
        coinButton.showsMenuAsPrimaryAction = true
        coinButton.changesSelectionAsPrimaryAction = true
    }
}
