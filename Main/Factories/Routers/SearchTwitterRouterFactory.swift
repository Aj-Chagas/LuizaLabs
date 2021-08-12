//
//  SearchTwitterRouterFactory.swift
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

private let tweetTimelineController: (_ nav: UINavigationController, _ tweetViewModel: [TweetViewModel], _ twitterViewModel: TwitterProfileViewModel) -> TweetTimelineViewController = { nav, tweetViewModel, twitterViewModel in
    return makeTweetTimeViewController(router: makeTweetTimelineRouter(nav: nav),
                                       twitterViewModel: twitterViewModel, tweetViewModel: tweetViewModel)
}

func makeSearchTwitterRouter(nav: UINavigationController) -> SearchTwitterRouter {
    SearchTwitterRouter(nav: nav, errorFactory: errorFactory, tweetTimelineFactory: tweetTimelineController)
}
