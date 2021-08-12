//
//  TweetTimelineRouterFactory.swift
//  Main
//
//  Created by Anderson Chagas on 11/08/21.
//

import UI
import UIKit
import Presentation

private let errorFactory: () -> ErrorGenericViewController = {
    return ErrorGenericViewController.instantiate()
}

public let conclusionFactory: (_ tweet: String,
                               _ analyzeSentimentViewModel: AnalyzeSentimentViewModel) -> ConclusionViewController = { tweet, analyzeSentimentViewModel in
    makeConclusionFactory(tweet: tweet, analyzeSentimentViewModel: analyzeSentimentViewModel)
}

func makeTweetTimelineRouter(nav: UINavigationController) -> TweetTimelineRouter {
    TweetTimelineRouter(nav: nav, errorFactory: errorFactory, conclusionFactory: conclusionFactory)
}
