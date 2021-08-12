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

    let presenter = TimelinePresenter(analyzeSentiment: makeRemoteAnalyzeSentiment(), loadingView: controller, delegate: controller)

    controller.analyzeSentimet = presenter.analyzeSentiment
    controller.goToError = router.goToError
    controller.tweetViewModel = tweetViewModel
    controller.twitterViewModel = twitterViewModel
    
    return controller
}

