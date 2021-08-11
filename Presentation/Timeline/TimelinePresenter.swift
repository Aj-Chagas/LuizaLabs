//
//  TimelinePresenter.swift
//  Presentation
//
//  Created by Anderson Chagas on 10/08/21.
//

import Foundation
import Domain

public final class TimelinePresenter {
    private let analyzeSentiment: AnalyzeSentiment
    
    public init(analyzeSentiment: AnalyzeSentiment) {
        self.analyzeSentiment = analyzeSentiment
    }
    
    public func analyzeSentiment(with model: FetchAnalyzeSentimentModel) {
        analyzeSentiment.fetchAnalyzeSentiment(fetchTweetTimeLineModel: model) { _ in }
    }
}
