//
//  TweetTimelineFactory.swift
//  Main
//
//  Created by Anderson Chagas on 11/08/21.
//

import Foundation
import UI
import Presentation

public func makeTweetTimeViewController(router: TweetTimelineRouter,
                                        twitterViewModel: TwitterProfileViewModel, tweetViewModel: [TweetViewModel]) -> TweetTimelineViewController {
    let controller = TweetTimelineViewController.instantiate()

    let presenter = TimelinePresenter(analyzeSentiment: makeRemoteAnalyzeSentiment(),
                                      loadingView: WeakVarProxy(controller),
                                      delegate: WeakVarProxy(controller))

    controller.analyzeSentimet = presenter.analyzeSentiment
    controller.goToError = router.goToError
    controller.goToConclusion = router.goToConclusion
    controller.tweetViewModel = tweetViewModel
    controller.twitterViewModel = twitterViewModel
    
    return controller
}

