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
    private let httpGetClient: HttpClient
    private let params: [String: Any]
    private let header: [String: String]
    
    
    public init(url: URL,
                httpGetClient: HttpClient,
                params: [String: Any], header: [String: String]) {
        self.url = url
        self.httpGetClient = httpGetClient
        self.params = params
        self.header = header
    }

    public func fetchTweetTimeLine(fetchTweetTimeLineModel model: FetchTweetTimelineModel, completion: @escaping (TweetTimeline.Result) -> Void) {
        httpGetClient.request(to: makeTweetTimeLineUrl(model), method: .get, params: params, headers: header) { result in
            switch result {
            case .success(let data):
                if let model: TweetTimelineModel = data?.toModel() {
                    completion(.success(model))
                } else {
                    completion(.failure(.unexpected))
                }
            case .failure: completion(.failure(.unexpected))
            }
            
        }
    }
    
    public func makeTweetTimeLineUrl(_ model: FetchTweetTimelineModel) -> URL {
        guard let newUrl = URL(string: url.absoluteString.replacingOccurrences(of: ":id", with: model.id)) else {
            return url
        }
        return newUrl
    }
}
