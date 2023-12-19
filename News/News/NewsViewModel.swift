//
//  NewsViewModel.swift
//  News
//
//  Created by Mathias Erligmann on 19/12/2023.
//

import Foundation

class NewsViewModel {
    var news = [News]()

    func fetchFrenchNews(completion: @escaping () -> Void) {
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=fr&apiKey=8799411f480046e2ac216f6a11d69914")!

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "Unknown error")
                return
            }

            if let newsResponse = try? JSONDecoder().decode(NewsResponse.self, from: data) {
                DispatchQueue.main.async {
                    self.news = newsResponse.articles
                    completion()
                }
            }
        }.resume()
    }
}

