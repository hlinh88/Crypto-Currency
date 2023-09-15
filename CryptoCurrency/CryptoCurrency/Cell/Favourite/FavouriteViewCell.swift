//
//  FavouriteViewCell.swift
//  CryptoCurrency
//
//  Created by Hoang Linh Nguyen on 14/9/2023.
//

import UIKit

final class FavouriteViewCell: UITableViewCell {
    @IBOutlet private weak var topLeftView: UIView!
    @IBOutlet private weak var topRightView: UIView!
    @IBOutlet private weak var bottomLeftView: UIView!
    @IBOutlet private weak var bottomRightView: UIView!
    @IBOutlet private weak var coinImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        customizeCell()
    }

    private func customizeCell() {
        topLeftView.roundTopLeftCorner()
        topRightView.roundTopRightCorner()
        bottomLeftView.roundBottomLeftCorner()
        bottomRightView.roundBottomRightCorner()
        coinImage.layer.cornerRadius = LayerSettings.radius.rawValue
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
