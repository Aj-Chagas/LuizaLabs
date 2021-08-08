//
//  RemoteTweetTimeline.swift
//  Data
//
//  Created by Anderson Chagas on 08/08/21.
//

import Foundation
import Domain

public final class RemoteTweetTimeline: TweetTimeline {

    private let url: URL
    private let httpGetClient: HttpGetClient
    private let params: [String: Any]
    private let header: [String: String]
    
    
    public init(url: URL,
                httpGetClient: HttpGetClient,
                params: [String: Any], header: [String: String]) {
        self.url = url
        self.httpGetClient = httpGetClient
        self.params = params
        self.header = header
    }

    public func fetchTweetTimeLine(fetchTweetTimeLineModel: FetchTweetTimelineModel, completion: @escaping (TweetTimeline.Result) -> Void) {
        httpGetClient.get(to: url, params: params, headers: header, completion: { _ in})
    }
}
