//
//  CoinsViewCell.swift
//  CryptoCurrency
//
//  Created by Hoang Linh Nguyen on 18/9/2023.
//

import UIKit

final class CoinsViewCell: UITableViewCell {
    @IBOutlet private weak var coinImageView: UIImageView!
    @IBOutlet private weak var coinNameLabel: UILabel!
    @IBOutlet private weak var coinSymbolLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configCoinCell(thisCoin: Coin) {
        ViewManager.shared.setImagePNG(stringURL: thisCoin.iconUrl,
                                       imageView: coinImageView,
                                       viewController: CoinsViewController())
        coinNameLabel.text = thisCoin.name
        coinSymbolLabel.text = thisCoin.symbol
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
