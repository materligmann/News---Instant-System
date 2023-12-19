//
//  NewsModels.swift
//  News
//
//  Created by Mathias Erligmann on 19/12/2023.
//

import Foundation


struct News: Codable {
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
}

struct NewsResponse: Codable {
    let articles: [News]
}
