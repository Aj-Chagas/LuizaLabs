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
    private let httpClient: HttpClient
    
    public init(url: URL, httpClient: HttpClient) {
        self.url = url
        self.httpClient = httpClient
    }
    
    public func fetchAnalyzeSentiment(fetchTweetTimeLineModel model: FetchAnalyzeSentimentModel, completion: @escaping (AnalyzeSentiment.Result) -> Void) {
        httpClient.request(to: url, method: .post, params: model.toJson(), headers: nil) { result in
            switch result {
            case .success(let data):
                if let model: AnalyzeSentimentModel = data?.toModel() {
                    completion(.success(model))
                } else {
                    completion(.failure(.unexpected))
                }
            case .failure: completion(.failure(.unexpected))
            }
        }
    }
}
