//
//  NewsDetailViewModel.swift
//  News
//
//  Created by Mathias Erligmann on 19/12/2023.
//

import Foundation

class NewsDetailViewModel {
    let newsItem: News

    var title: String {
        return newsItem.title
    }

    var description: String {
        return newsItem.description ?? "No description available."
    }

    var imageURL: URL? {
        return URL(string: newsItem.urlToImage ?? "")
    }

    init(newsItem: News) {
        self.newsItem = newsItem
    }

    // Add any additional logic or data transformation here
}
