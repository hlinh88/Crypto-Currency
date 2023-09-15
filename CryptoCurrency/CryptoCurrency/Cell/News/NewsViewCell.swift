//
//  NewsViewCell.swift
//  CryptoCurrency
//
//  Created by Hoang Linh Nguyen on 15/9/2023.
//

import UIKit

final class NewsViewCell: UITableViewCell {
    @IBOutlet private weak var newsStackView: UIStackView!
    @IBOutlet private weak var newsLeftView: UIView!
    @IBOutlet private weak var newsRightView: UIView!
    @IBOutlet private weak var newsImageView: UIImageView!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var sourceLabel: UILabel!

    private var url = ""

    override func awakeFromNib() {
        super.awakeFromNib()
        customizeCell()
    }

    func configNews(thisNews: News) {
        ViewManager.shared.setImagePNG(stringURL: thisNews.articlePhotoUrl,
                                       imageView: newsImageView,
                                       viewController: NewsViewController())
        dateLabel.text = thisNews.postTimeUtc
        titleLabel.text = thisNews.articleTitle
        sourceLabel.text = thisNews.source
        linkURL = thisNews.articleUrl
    }

    private func customizeCell() {
        newsLeftView.roundLeftCorners()
        newsRightView.roundRightCorners()
        newsImageView.layer.cornerRadius = LayerSettings.radius.rawValue
        newsImageView.layer.masksToBounds = true
        newsStackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(newsStackViewClicked)))
    }

    @objc func newsStackViewClicked() {
        guard let url = URL(string: self.url) else { return }
        UIApplication.shared.open(url)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
