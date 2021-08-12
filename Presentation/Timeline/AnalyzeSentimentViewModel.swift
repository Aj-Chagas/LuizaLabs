//
//  AnalyzeSentimentViewModel.swift
//  Presentation
//
//  Created by Anderson Chagas on 12/08/21.
//

import Foundation
import Domain

public struct AnalyzeSentimentViewModel: Model {
    private let analyzeSentiment: AnalyzeSentimentModel

    public init(analyzeSentiment: AnalyzeSentimentModel) {
        self.analyzeSentiment = analyzeSentiment
    }

    public var magnitude: Double {
        analyzeSentiment.documentSentiment.magnitude
    }

    public var score: Double {
        analyzeSentiment.documentSentiment.score
    }

}
