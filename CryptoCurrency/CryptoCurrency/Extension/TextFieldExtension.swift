//
//  TextFieldExtension.swift
//  CryptoCurrency
//
//  Created by Hoang Linh Nguyen on 16/9/2023.
//

import UIKit

extension UITextField {
    func customizeSearch() {
        self.backgroundColor = UIColor.buttonColor
        self.layer.masksToBounds = true
        self.layer.cornerRadius = LayerSettings.radius.rawValue
        self.font = .systemFont(ofSize: 15, weight: .medium)
        self.attributedPlaceholder = NSAttributedString(
            string: "Search",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        self.leftViewMode = UITextField.ViewMode.always
        let iconContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: self.bounds.height))
        let iconView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        iconView.center = CGPoint(x: iconContainerView.frame.size.width  / 2,
                                  y: iconContainerView.frame.size.height / 2)
        let image = UIImage(systemName: "magnifyingglass.circle.fill")
        iconView.image = image
        iconView.tintColor = UIColor.white
        iconContainerView.addSubview(iconView)
        self.leftView = iconContainerView
        self.modifyClearButton()
    }

    @objc func modifyClearButton() {
        let buttonContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: self.bounds.height))
        let clearButton = UIButton(type: .custom)
        clearButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        clearButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        clearButton.center = CGPoint(x: buttonContainerView.frame.size.width  / 2,
                                  y: buttonContainerView.frame.size.height / 2)
        clearButton.contentMode = .scaleAspectFit
        clearButton.addTarget(self, action: #selector(clear(_:)), for: .touchUpInside)
        clearButton.tintColor = UIColor.white
        buttonContainerView.addSubview(clearButton)
        rightView = buttonContainerView
        rightViewMode = .whileEditing
    }

    @objc func clear(_ sender: AnyObject) {
        self.text = ""
        sendActions(for: .editingChanged)
    }
}
