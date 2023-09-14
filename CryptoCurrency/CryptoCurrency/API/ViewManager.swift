//
//  ViewManager.swift
//  CryptoCurrency
//
//  Created by Hoang Linh Nguyen on 14/9/2023.
//

import UIKit

final class ViewManager {
    static let shared = ViewManager()

    private init() {}

    func checkChangeRate(rate: String) -> Bool {
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

    func setImagePNG(stringURL: String, imageView: UIImageView, viewController: UIViewController) {
        let finalStringUrl = convertSVGToPNG(stringURL: stringURL)
        APIManager.shared.getImageData(stringURL: finalStringUrl) { (data: Data) in
            DispatchQueue.main.async {
                imageView.image = UIImage(data: data)
            }
        } errorHandler: {
            viewController.popUpErrorAlert(message: "Error loading image")
        }
    }
}
