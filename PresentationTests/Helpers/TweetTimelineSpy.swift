//
//  TweetTimelineSpy.swift
//  PresentationTests
//
//  Created by Anderson Chagas on 09/08/21.
//

import Foundation
import Domain

class TweetTimelineSpy: TweetTimeline {

    var model: FetchTweetTimelineModel?
    var completion: ((TweetTimeline.Result) -> Void)?

    func fetchTweetTimeLine(fetchTweetTimeLineModel model: FetchTweetTimelineModel, completion: @escaping (TweetTimeline.Result) -> Void) {
        self.model = model
        self.completion = completion
    }

}
