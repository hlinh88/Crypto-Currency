//
//  FavouriteViewController.swift
//  CryptoCurrency
//
//  Created by Hoang Linh Nguyen on 12/9/2023.
//

import UIKit

final class FavouriteViewController: UIViewController {
    @IBOutlet private weak var favouriteTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        favouriteTableView.reloadData()
    }

    private func registerTableView() {
        favouriteTableView.register(UINib(nibName: "FavouriteViewCell", bundle: nil),
                                    forCellReuseIdentifier: "favouriteCellId")
        favouriteTableView.delegate = self
        favouriteTableView.dataSource = self
    }
}

extension FavouriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FavouriteManager.favourites.count
    }
}

extension FavouriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = favouriteTableView.dequeueReusableCell(withIdentifier: "favouriteCellId", for: indexPath)
            as? FavouriteViewCell {
            cell.delegate = self
            cell.configFavouriteCell(thisFavourite: FavouriteManager.favourites[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}

extension FavouriteViewController: FavouriteViewCellDelegate {
    func removeButtonTapped(sender: UIButton) {
        self.favouriteTableView.reloadData()
    }
}
