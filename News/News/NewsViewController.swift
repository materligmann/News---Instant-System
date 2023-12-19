//
//  ViewController.swift
//  News
//
//  Created by Mathias Erligmann on 19/12/2023.
//

import UIKit

import UIKit

class NewsViewController: UIViewController {
    private let viewModel = NewsViewModel()
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackground()
        configureTableView()
        viewModel.fetchFrenchNews {
            self.tableView.reloadData()
        }
    }
    
    private func configureBackground() {
        view.backgroundColor = .white
    }

    private func configureTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 100
        tableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.cellIdentifier)
        tableView.frame = view.bounds
    }
}


extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.news.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.cellIdentifier, for: indexPath) as? NewsCell {
            cell.set(news: viewModel.news[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let newsDetailViewController = NewsDetailViewController()
        let detailViewModel = NewsDetailViewModel(newsItem: viewModel.news[indexPath.row])
        newsDetailViewController.viewModel = detailViewModel
        navigationController?.pushViewController(newsDetailViewController, animated: true)
    }
}
