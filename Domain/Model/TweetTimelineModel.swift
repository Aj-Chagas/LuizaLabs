//
//  TweetTimelineModel.swift
//  Domain
//
//  Created by Anderson Chagas on 08/08/21.
//

import Foundation

public struct TweetTimelineModel: Model {
    public let data: Tweet
    
    public init(data: Tweet) {
        self.data = data
    }
}

public struct Tweet: Model {
    public let id: String
    public let text: String
    
    public init(id: String, text: String) {
        self.id = id
        self.text = text
    }
}
