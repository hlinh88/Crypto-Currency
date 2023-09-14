//
//  TabBarController.swift
//  CryptoCurrency
//
//  Created by Hoang Linh Nguyen on 13/9/2023.
//

import UIKit

final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeVC = HomeViewController()
        let favouriteVC = FavouriteViewController()
        let exchangeVC = ExchangeViewController()
        let newsVC = NewsViewController()

        self.setViewControllers([homeVC, favouriteVC, exchangeVC, newsVC], animated: false)

        configTabBar()
    }

    private func configTabBar() {
        guard let items = self.tabBar.items else { return }

        let images = ["house", "heart.circle", "dollarsign.circle", "newspaper"]
        let selectedImages = ["house.fill", "heart.circle.fill", "dollarsign.circle.fill", "newspaper.fill"]
        let titles = ["Home", "Favourite", "Exchange", "News"]

        for index in 0...(items.count-1) {
            items[index].image = UIImage(systemName: images[index])
            items[index].selectedImage = UIImage(systemName: selectedImages[index])
            items[index].title = titles[index]
        }

        self.tabBar.backgroundColor = .black
        self.tabBar.tintColor = UIColor.mainColor
    }

    class func instantiateFromNib() -> TabBarController {
        let nib = UINib(nibName: "TabBarController", bundle: nil)
        if let tabBarVC = nib.instantiate(withOwner: nil, options: nil).first as? TabBarController {
            return tabBarVC
        }
        return TabBarController()
    }
}
