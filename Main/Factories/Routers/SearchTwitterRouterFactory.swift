//
//  SearchTwitterRouterFactory.swift
//  Main
//
//  Created by Anderson Chagas on 11/08/21.
//

import UI
import UIKit

private let errorFactory: () -> ErrorGenericViewController = {
    return ErrorGenericViewController.instantiate()
}

private let tweetTimelineController: () -> TweetTimelineViewController = {
    return TweetTimelineViewController.instantiate()
}

func makeSearchTwitterRouter(nav: UINavigationController) -> SearchTwitterRouter {
    SearchTwitterRouter(nav: nav, errorFactory: errorFactory, tweetTimelineFactory: tweetTimelineController)
}
