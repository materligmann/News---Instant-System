//
//  NewsTests.swift
//  NewsTests
//
//  Created by Mathias Erligmann on 19/12/2023.
//

import XCTest
@testable import News

class NewsViewModelTests: XCTestCase {

    var viewModel: NewsViewModel!

    override func setUp() {
        super.setUp()
        viewModel = NewsViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testNewsViewModelHasNewsAfterFetch() {
        let expectation = self.expectation(description: "NewsFetch")

        viewModel.fetchFrenchNews {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertFalse(self.viewModel.news.isEmpty, "The news array should not be empty after fetching news.")
    }

    // Note: Real network calls in unit tests are generally discouraged
    // due to their unpredictability and dependency on external factors.
}

class NewsDetailViewModelTests: XCTestCase {

    func testInitialization() {
        let newsItem = News(title: "Detail Test", description: "Detail Description", url: "https://example.com", urlToImage: nil)
        let viewModel = NewsDetailViewModel(newsItem: newsItem)

        XCTAssertEqual(viewModel.title, "Detail Test")
        XCTAssertEqual(viewModel.description, "Detail Description")
    }

    // Add more tests as needed to cover all aspects of the NewsDetailViewModel
}
