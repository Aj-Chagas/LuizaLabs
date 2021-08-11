//
//  TimelinePresenter.swift
//  Presentation
//
//  Created by Anderson Chagas on 10/08/21.
//

import Foundation
import Domain

public protocol TimelineDelegate: AnyObject {
    func handlerError()
    func handlerSuccess()
}

public final class TimelinePresenter {
    private let analyzeSentiment: AnalyzeSentiment
    private let delegate: TimelineDelegate
    
    public init(analyzeSentiment: AnalyzeSentiment,
                delegate: TimelineDelegate) {
        self.analyzeSentiment = analyzeSentiment
        self.delegate = delegate
    }
    
    public func analyzeSentiment(with model: FetchAnalyzeSentimentModel) {
        analyzeSentiment.fetchAnalyzeSentiment(fetchTweetTimeLineModel: model) { result in
            switch result {
            case .success: self.delegate.handlerSuccess()
            case .failure: self.delegate.handlerError()
            }
        }
    }
}
