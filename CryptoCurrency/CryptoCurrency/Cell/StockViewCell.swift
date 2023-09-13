//
//  StockViewCell.swift
//  CryptoCurrency
//
//  Created by Hoang Linh Nguyen on 13/9/2023.
//

import UIKit

final class StockViewCell: UITableViewCell {
    @IBOutlet private weak var stockImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        customizeCell()
    }

    private func customizeCell() {
        stockImage.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
