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
        stockImage.layer.cornerRadius = 10
    }

    func configStock(ranking: Int, thisCoin: Coin) {
        setImagePNG(stringURL: thisCoin.iconUrl)
        rankingLabel.text = "\(ranking)"
        coinLabel.text = thisCoin.name
        symbolLabel.text = thisCoin.symbol

        if let price = Double(thisCoin.price) {
            priceLabel.text = "$\(String(format: "%.2f", price))"
        }

        changeLabel.text = "\(thisCoin.change) %"
        let isChanged = checkChangeRate(rate: thisCoin.change)
        changeLabel.textColor = isChanged ? .systemGreen : .systemRed
        changeImage.image = isChanged
        ? UIImage(systemName: "arrowtriangle.up.fill")
        : UIImage(systemName: "arrowtriangle.down.fill")
        changeImage.tintColor = isChanged ? .systemGreen : .systemRed
        
        if let imageColor = thisCoin.color {
            stockImage.backgroundColor = UIColor.init(hexString: imageColor)
        }
    }

    private func checkChangeRate(rate: String) -> Bool {
        return !(rate.prefix(1) == "-")
    }

    private func convertSVGToPNG(stringURL: String) -> String {
        let fileType = String(stringURL.suffix(3))
        if fileType == "svg" {
            let raw = stringURL.dropLast(3)
            let newStringURL = raw + "png"
            return String(newStringURL)
        }
        return stringURL
    }

    func setImagePNG(stringURL: String) {
        let finalStringUrl = convertSVGToPNG(stringURL: stringURL)
        APIManager.shared.getImageData(stringURL: finalStringUrl) { (data: Data) in
            DispatchQueue.main.async { [weak self] in
                self?.stockImage.image = UIImage(data: data)
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
