//
//  SearchTwitterFactory.swift
//  Main
//
//  Created by Anderson Chagas on 11/08/21.
//

import Foundation
import UI
import Presentation

public func makeSearchTwitterFactory(router: SearchTwitterRouter) -> SearchTwitterViewController {
    let controller = SearchTwitterViewController.instantiate()
    let presenter = SearchTwitterPresenter(twitterProfile: makeRemoteTwitterProfile(),
                                           tweetTimeline: makeRemoteTweetTimeline(),
                                           delegate: WeakVarProxy(controller),
                                           loadingView: WeakVarProxy(controller))
    controller.searchTwitter = presenter.searchTwitter
    controller.errorFactory = router.goToError
    controller.tweetTimelineFactory = router.goToTweetTimeline
    return controller
}

