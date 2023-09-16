//
//  StockViewCell.swift
//  CryptoCurrency
//
//  Created by Hoang Linh Nguyen on 13/9/2023.
//

import UIKit

final class StockViewCell: UITableViewCell {
    @IBOutlet private weak var rankingLabel: UILabel!
    @IBOutlet private weak var coinLabel: UILabel!
    @IBOutlet private weak var symbolLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var changeLabel: UILabel!
    @IBOutlet private weak var stockImage: UIImageView!
    @IBOutlet private weak var changeImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        customizeCell()
    }

    private func customizeCell() {
        stockImage.layer.cornerRadius = LayerSettings.radius.rawValue
    }

    func configStock(ranking: Int, thisCoin: Coin) {
        ViewManager.shared.setImagePNG(stringURL: thisCoin.iconUrl,
                                       imageView: stockImage,
                                       viewController: HomeViewController())
        rankingLabel.text = "\(ranking)"
        coinLabel.text = thisCoin.name
        symbolLabel.text = thisCoin.symbol

        if let price = Double(thisCoin.price) {
            priceLabel.text = "$\(String(format: "%.2f", price))"
        }

        changeLabel.text = "\(thisCoin.change) %"
        let isChanged = ViewManager.shared.checkChangeRate(rate: thisCoin.change)
        changeLabel.textColor = isChanged ? .systemGreen : .systemRed
        changeImage.image = isChanged
        ? UIImage(systemName: "arrowtriangle.up.fill")
        : UIImage(systemName: "arrowtriangle.down.fill")
        changeImage.tintColor = isChanged ? .systemGreen : .systemRed
        if let imageColor = thisCoin.color {
            stockImage.backgroundColor = imageColor == "#000000" ? UIColor.white : UIColor.init(hexString: imageColor)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
