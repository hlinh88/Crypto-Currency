//
//  ViewExtension.swift
//  CryptoCurrency
//
//  Created by Hoang Linh Nguyen on 14/9/2023.
//

import UIKit

extension UIView {
    func roundTopLeftCorner() {
        self.layer.cornerRadius = 10
        self.layer.maskedCorners = .layerMinXMinYCorner
        self.layer.masksToBounds = true
    }

    func roundTopRightCorner() {
        self.layer.cornerRadius = 10
        self.layer.maskedCorners = .layerMaxXMinYCorner
        self.layer.masksToBounds = true
    }

    func roundBottomLeftCorner() {
        self.layer.cornerRadius = 10
        self.layer.maskedCorners = .layerMinXMaxYCorner
        self.layer.masksToBounds = true
    }

    func roundBottomRightCorner() {
        self.layer.cornerRadius = 10
        self.layer.maskedCorners = .layerMaxXMaxYCorner
        self.layer.masksToBounds = true
    }

    func roundLeftCorners() {
        self.layer.cornerRadius = 10
        self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        self.layer.masksToBounds = true
    }

    func roundRightCorners() {
        self.layer.cornerRadius = 10
        self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        self.layer.masksToBounds = true
    }
}
