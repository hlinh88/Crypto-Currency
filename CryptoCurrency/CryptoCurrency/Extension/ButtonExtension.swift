//
//  ButtonExtension.swift
//  CryptoCurrency
//
//  Created by Hoang Linh Nguyen on 13/9/2023.
//

import UIKit

extension UIButton {
    func addShadow() {
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 5
    }

    func customizePopUpButton() {
        self.backgroundColor = UIColor.buttonColor
        self.layer.cornerRadius = 10
        self.tintColor = UIColor.white
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
    }

    func roundButton() {
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}
