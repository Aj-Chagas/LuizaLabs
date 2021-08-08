//
//  TweetTimeline.swift
//  Domain
//
//  Created by Anderson Chagas on 08/08/21.
//

import Foundation

public protocol TweetTimeline {
    typealias Result = Swift.Result<TweetTimelineModel, DomainError>
    func fetchTweetTimeLine(fetchTweetTimeLineModel: FetchTweetTimelineModel, completion: @escaping (Result) -> Void )
}

public struct FetchTweetTimelineModel: Model {
    public let id: String

    public init(id: String) {
        self.id = id
    }
}
