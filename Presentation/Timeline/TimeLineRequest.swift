//
//  TimeLineRequest.swift
//  Presentation
//
//  Created by Anderson Chagas on 11/08/21.
//

import Foundation
import Domain

public struct TimeLineRequest: Model {

    public var tweet: String

    public init(tweet: String) {
        self.tweet = tweet
    }

    public func toFetchAnalyzeSentimentModel() -> FetchAnalyzeSentimentModel {
        FetchAnalyzeSentimentModel(document: Document(content: tweet))
    }
}
