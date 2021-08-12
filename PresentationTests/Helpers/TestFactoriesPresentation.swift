//
//  TestFactories.swift
//  PresentationTests
//
//  Created by Anderson Chagas on 09/08/21.
//

import Foundation
import Presentation
import Domain

func makeSearchTwitterRequest(userName: String = "any_name") -> SearchTwitterRequest {
    SearchTwitterRequest(userName: userName)
}

func makeTweetViewModel() -> [TweetViewModel] {
    [TweetViewModel(tweet: Tweet(id: "any_id", text: "any_tweet"))]
}

func makeTwitterProfileViewModel() -> TwitterProfileViewModel {
    TwitterProfileViewModel(twitterProfile: makeTwitterProfileModel())
}

func makeTimelineRequest() -> TimeLineRequest {
    TimeLineRequest(tweet: "any_tweet")
}

func makeAnalyzeSentimentViewModel() -> AnalyzeSentimentViewModel {
    AnalyzeSentimentViewModel(analyzeSentiment: AnalyzeSentimentModel(documentSentiment: DocumentSentiment(magnitude: 0.0, score: 0.0), language: "en"))
}
