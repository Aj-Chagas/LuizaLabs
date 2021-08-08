//
//  AnalyzeSentimentModel.swift
//  Domain
//
//  Created by Anderson Chagas on 08/08/21.
//

import Foundation

public struct AnalyzeSentimentModel: Model {
    public let documentSentiment: DocumentSentiment
    public let language: String
}

public struct DocumentSentiment: Model {
    public let magnitude: Double
    public let score: Double
}
