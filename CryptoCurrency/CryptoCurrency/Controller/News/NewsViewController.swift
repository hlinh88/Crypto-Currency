//
//  NewsViewController.swift
//  CryptoCurrency
//
//  Created by Hoang Linh Nguyen on 12/9/2023.
//

import UIKit

final class NewsViewController: UIViewController {
    @IBOutlet private weak var newsTableView: UITableView!

    private var news = [News]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableView()
        getNews()
    }

    private func getNews() {
        let queue = DispatchQueue(label: "getNewsQueue", qos: .utility)
        queue.async { [unowned self] in
            APIManager.shared.fetchNews(completion: { (newsList: [News]) in
                _ = newsList.map { new in
                    self.news.append(News(articleTitle: new.articleTitle,
                                          articleUrl: new.articleUrl,
                                          articlePhotoUrl: new.articlePhotoUrl,
                                          source: new.source,
                                          postTimeUtc: new.postTimeUtc))
                }
                self.newsTableView.reloadData()
            }, errorHandler: {
                self.popUpErrorAlert(message: "Error fetching News API")
            })
        }
    }

    private func registerTableView() {
        newsTableView.register(UINib(nibName: "NewsViewCell", bundle: nil), forCellReuseIdentifier: "newsCellId")
        newsTableView.delegate = self
        newsTableView.dataSource = self
    }
}

extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
}

extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = newsTableView.dequeueReusableCell(withIdentifier: "newsCellId", for: indexPath)
            as? NewsViewCell {
            cell.configNews(thisNews: news[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
