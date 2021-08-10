//
//  TweetViewModel.swift
//  Presentation
//
//  Created by Anderson Chagas on 10/08/21.
//

import Foundation
import Domain

public struct TweetViewModel: Model {

    public var tweet: Tweet

    public init(tweet: Tweet) {
        self.tweet = tweet
    }
    
    public var id: String {
        tweet.id
    }

    public var text: String {
        tweet.text
    }
    
}
