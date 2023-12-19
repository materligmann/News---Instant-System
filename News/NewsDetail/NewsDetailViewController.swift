//
//  NewsDetailViewController.swift
//  News
//
//  Created by Mathias Erligmann on 19/12/2023.
//

import UIKit
import SafariServices

class NewsDetailViewController: UIViewController {
    
    var viewModel: NewsDetailViewModel?

    private let newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 3
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        configureWithViewModel()
    }

    private func setupLayout() {
        configureSafariButton()
        view.addSubview(newsImageView)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        newsImageView.frame = CGRect(x: 10, y: 80, width: view.frame.size.width - 20, height: 200)
        titleLabel.frame = CGRect(x: 10, y: 300, width: view.frame.size.width - 20, height: 100)
        descriptionLabel.frame = CGRect(x: 10, y: 350, width: view.frame.size.width - 20, height: 100)
    }
    
    private func configureSafariButton() {
        let button = UIBarButtonItem()
        button.image = UIImage(systemName: "safari")
        button.target = self
        button.action = #selector(onSafariButton)
        navigationItem.rightBarButtonItem = button
    }

    private func configureWithViewModel() {
        titleLabel.text = viewModel?.title
        descriptionLabel.text = viewModel?.description

        if let imageURL = viewModel?.imageURL {
            newsImageView.downloaded(from: imageURL)
        }
    }
    
    // MARK: Action
    
    @objc private func onSafariButton() {
        if let url = URL(string: viewModel?.newsItem.url ?? "") {
            let safariViewController = SFSafariViewController(url: url)
            navigationController?.present(safariViewController, animated: true)
        }
    }
}

