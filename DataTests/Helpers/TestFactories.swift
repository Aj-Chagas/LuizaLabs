//
//  TestFactories.swift
//  DataTests
//
//  Created by Anderson Chagas on 07/08/21.
//

import Foundation
import Domain

func makeFetchTwitterProfileModel() -> FetchTwitterProfileModel {
    FetchTwitterProfileModel(userName: "any_name")
}

func makeTwitterProfileModel() -> TwitterProfileModel {
    TwitterProfileModel(data: Profile(id: "any_id", name: "any_name", username: "any_userName"))
}

func makeAnalyzeSentimentModel() -> AnalyzeSentimentModel {
    AnalyzeSentimentModel(documentSentiment: DocumentSentiment(magnitude: 0.0, score: 0.0), language: "en")
}

func makeTweetTimelineModel() -> TweetTimelineModel {
    TweetTimelineModel(data: [Tweet(id: "any_id", text: "any_tweet")])
}

func makeInvalidFetchTwitterProfileModel() -> FetchTwitterProfileModel {
    FetchTwitterProfileModel(userName: "˜!@")
}

func makeFetchTwitterTimeLine() -> FetchTweetTimelineModel {
    FetchTweetTimelineModel(id: "any_id")
}

func makeFetchAnalyzeSentimentModel() -> FetchAnalyzeSentimentModel {
    FetchAnalyzeSentimentModel(document: Document(content: "Enjoy your vacation!"))
}

func makeInvalidFetchTwitterTimeLine() -> FetchTweetTimelineModel {
    FetchTweetTimelineModel(id: "˜!@")
}

func makeHeader() -> [String: String] {
    ["any_name": "any_value"]
}

func makeParams() -> [String: Any] {
    ["any_Id": 24]
}

func makeUrl() -> URL {
    URL(string: "http://any-url.com/")!
}

func makeUrlWithPathID() -> URL {
    URL(string: "http://any-url.com/:id")!
}

func makeInvalidData() -> Data {
    Data("invalid_data".utf8)
}

func makeValidData() -> Data {
    Data("{\"name\": \"Anderson\"}".utf8)
}

func makeHttpResponse(statusCode: Int = 200) -> HTTPURLResponse {
    HTTPURLResponse(url: makeUrl(), statusCode: statusCode, httpVersion: nil, headerFields: nil)!
}

func makeError() -> NSError {
    NSError(domain: "any_error", code: 0)
}
