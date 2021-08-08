//
//  RemoteAnalyzeSentiment.swift
//  Data
//
//  Created by Anderson Chagas on 08/08/21.
//

import Foundation
import Domain

public final class RemoteAnalyzeSentiment: AnalyzeSentiment {

    private let url: URL
    private let httpPostClient: HttpPostClient
    
    public init(url: URL, httpPostClient: HttpPostClient) {
        self.url = url
        self.httpPostClient = httpPostClient
    }
    
    public func fetchAnalyzeSentiment(fetchTweetTimeLineModel model: FetchAnalyzeSentimentModel, completion: @escaping (AnalyzeSentiment.Result) -> Void) {
        httpPostClient.post(to: url, params: nil) { _ in }
    }
}
