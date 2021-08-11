//
//  SearchTwitterFactory.swift
//  Main
//
//  Created by Anderson Chagas on 11/08/21.
//

import UIKit
import UI
import Presentation
import Domain
import Data
import Infra

public func makeSearchTwitterFactory(router: SearchTwitterRouter) -> SearchTwitterViewController {
    let controller = SearchTwitterViewController.instantiate()
    let twitterProfile = makeRemoteTwitterProfile()
    let tweetTimeline = makeRemoteTweetTimeline()
    let presenter = SearchTwitterPresenter(twitterProfile: twitterProfile, tweetTimeline: tweetTimeline, delegate: controller, loadingView: controller)
    controller.searchTwitter = presenter.searchTwitter

    controller.errorFactory = router.goToError
    controller.tweetTimelineFactory = router.goToTweetTimeline
    return controller
}

