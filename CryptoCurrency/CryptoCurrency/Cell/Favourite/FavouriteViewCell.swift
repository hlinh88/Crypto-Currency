//
//  FavouriteViewCell.swift
//  CryptoCurrency
//
//  Created by Hoang Linh Nguyen on 14/9/2023.
//

import UIKit

protocol FavouriteViewCellDelegate: AnyObject {
    func removeButtonTapped(sender: UIButton)
}

final class FavouriteViewCell: UITableViewCell {
    @IBOutlet private weak var topLeftView: UIView!
    @IBOutlet private weak var topRightView: UIView!
    @IBOutlet private weak var bottomLeftView: UIView!
    @IBOutlet private weak var bottomRightView: UIView!
    @IBOutlet private weak var coinImage: UIImageView!

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var symbolLabel: UILabel!
    @IBOutlet private weak var removeButton: UIButton!
    @IBOutlet private weak var priceLabel: UILabel!

    private var uuid: String?
    weak var delegate: FavouriteViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        customizeCell()
    }

    func configFavouriteCell(thisFavourite: Favourite) {
        self.uuid = thisFavourite.uuid
        if let iconUrl = thisFavourite.iconUrl {
            ViewManager.shared.setImagePNG(stringURL: iconUrl,
                                           imageView: coinImage,
                                           viewController: FavouriteViewController())
        }
        nameLabel.text = thisFavourite.name
        symbolLabel.text = thisFavourite.symbol
        if let price = thisFavourite.price {
            if let priceValue = Double(price) {
                priceLabel.text = "$\(String(format: "%.2f", priceValue))"
            }
        }
        if let backgroundColor = thisFavourite.color {
            topLeftView.backgroundColor = backgroundColor == String.blackColor
            ? UIColor.white : UIColor.init(hexString: backgroundColor)
            topRightView.backgroundColor = backgroundColor == String.blackColor
            ? UIColor.white : UIColor.init(hexString: backgroundColor)
            nameLabel.textColor = backgroundColor == String.blackColor
            ? UIColor.black : UIColor.white
            symbolLabel.textColor = backgroundColor == String.blackColor
            ? UIColor.black : UIColor.white
            removeButton.setTitleColor( backgroundColor == String.blackColor
                                        ? UIColor.black : UIColor.white, for: .normal)
        }
    }

    private func customizeCell() {
        topLeftView.roundTopLeftCorner()
        topRightView.roundTopRightCorner()
        bottomLeftView.roundBottomLeftCorner()
        bottomRightView.roundBottomRightCorner()
        coinImage.layer.cornerRadius = LayerSettings.radius.rawValue
    }

    @IBAction private func handleRemoveButton(_ sender: UIButton) {
        if let uuid = self.uuid {
            CoreDataManager.shared.deleteItem(uuid: uuid)
            delegate?.removeButtonTapped(sender: sender)
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
