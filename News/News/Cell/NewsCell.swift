//
//  NewsCell.swift
//  News
//
//  Created by Mathias Erligmann on 19/12/2023.
//

import UIKit

class NewsCell: UITableViewCell {
    
    private let titleLabel = UILabel()
    private let newsImageView = UIImageView()
    
    class var cellIdentifier: String {
        return "NewsCell"
    }
    
    // MARK: Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureNewsImageView()
        configureTitleLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Set
    
    func set(news: News) {
        titleLabel.text = news.title
        if let url = URL(string: news.urlToImage ?? "") {
            newsImageView.downloaded(from: url)
        }
    }
    
    // MARK: Configure
    
    private func configureNewsImageView() {
        newsImageView.contentMode = .scaleAspectFit
        newsImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(newsImageView)
        newsImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        newsImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        newsImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        newsImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0).isActive = true
    }
    
    private func configureTitleLabel() {
        titleLabel.numberOfLines = 2
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        titleLabel.leftAnchor.constraint(equalTo: newsImageView.rightAnchor, constant: 10).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
    }
}

extension UIImageView {
    public func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType,
                mimeType.hasPrefix("image"),
                let data = data,
                error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
}
