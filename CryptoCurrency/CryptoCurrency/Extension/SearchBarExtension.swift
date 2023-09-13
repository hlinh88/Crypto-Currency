//
//  SearchBarExtension.swift
//  CryptoCurrency
//
//  Created by Hoang Linh Nguyen on 13/9/2023.
//

import UIKit

extension UISearchBar {
    func customizeSearchBar() {
        self.barTintColor = UIColor.clear
        self.backgroundColor = UIColor.buttonColor
        self.isTranslucent = true
        self.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        self.searchTextField.backgroundColor = UIColor.clear
        self.searchTextField.textColor = UIColor.white
        self.searchTextField.leftView?.tintColor = UIColor.white
        self.layer.cornerRadius = 10
        self.endEditing(true)
        self.setImage(UIImage(systemName: "magnifyingglass.circle.fill"), for: .search, state: .normal)
    }
}
