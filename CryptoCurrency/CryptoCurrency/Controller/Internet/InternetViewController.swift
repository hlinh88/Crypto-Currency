//
//  InternetViewController.swift
//  CryptoCurrency
//
//  Created by Hoang Linh Nguyen on 20/9/2023.
//

import UIKit

final class InternetViewController: UIViewController {
    @IBOutlet private weak var tryAgainButton: UIButton!
    @IBOutlet private weak var gifImageView: UIImageView!

    private lazy var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = tryAgainButton.bounds
        let gradientColors =  [UIColor.gradientColorTop.cgColor,
                               UIColor.gradientColorTopMid.cgColor,
                               UIColor.gradientColorBottomMid.cgColor,
                               UIColor.gradientColorBottom.cgColor]
        gradientLayer.colors = gradientColors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.cornerRadius = LayerSettings.radius.rawValue
        tryAgainButton.layer.insertSublayer(gradientLayer, at: 0)
        return gradientLayer
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        gifImageView.layer.cornerRadius = LayerSettings.radius.rawValue
        gradientLayer.frame = tryAgainButton.bounds
    }
    
    @IBAction private func handleTryAgainButton(_ sender: UIButton) {
        if InternetManager.shared.isInternetAvailable() {
            if let delegate = UIApplication.shared.delegate as? AppDelegate {
                delegate.restartApp()
            }
        }
    }
}
