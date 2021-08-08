//
//  AnalyzeSentiment.swift
//  Domain
//
//  Created by Anderson Chagas on 08/08/21.
//

import Foundation

public protocol AnalyzeSentiment {
    typealias Result = Swift.Result<AnalyzeSentimentModel, DomainError>
    func fetchTweetTimeLine(fetchTweetTimeLineModel model: FetchAnalyzeSentimentModel, completion: @escaping (Result) -> Void )
}

public struct FetchAnalyzeSentimentModel: Model {
    public let encodingType: String
    public let document: Document

    public init(encodingType: String = "UTF8",
                document: Document) {
        self.encodingType = encodingType
        self.document = document
    }
}

public struct Document: Model {
    public let type: String
    public let content: String
    
    public init(type: String, content: String) {
        self.type = type
        self.content = content
    }
}
