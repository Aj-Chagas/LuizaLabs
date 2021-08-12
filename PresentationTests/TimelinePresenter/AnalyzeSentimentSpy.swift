//
//  AnalyzeSentimentSpy.swift
//  PresentationTests
//
//  Created by Anderson Chagas on 12/08/21.
//

import Foundation
import Domain

class AnalyzeSentimentSpy: AnalyzeSentiment {

    var model: FetchAnalyzeSentimentModel?
    var completion: ((AnalyzeSentiment.Result) -> Void)?

    func fetchAnalyzeSentiment(fetchTweetTimeLineModel model: FetchAnalyzeSentimentModel, completion: @escaping (AnalyzeSentiment.Result) -> Void) {
        self.model = model
        self.completion = completion
    }

    func completionWithError(_ error: DomainError = .unexpected) {
        completion?(.failure(.unexpected))
    }
    
    func completionWithSuccess(_ model: AnalyzeSentimentModel) {
        completion?(.success(model))
    }

}
