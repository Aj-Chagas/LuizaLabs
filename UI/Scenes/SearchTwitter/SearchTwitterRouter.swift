//
//  SearchTwitterRouter.swift
//  UI
//
//  Created by Anderson Chagas on 11/08/21.
//

import UIKit
import Presentation

public final class SearchTwitterRouter {
    private let nav: UINavigationController
    private let errorFactory: () -> ErrorGenericViewController
    private let tweetTimelineFactory: (UINavigationController, [TweetViewModel], TwitterProfileViewModel) -> TweetTimelineViewController

    public init(nav: UINavigationController,
                errorFactory: @escaping () -> ErrorGenericViewController,
                tweetTimelineFactory: @escaping (UINavigationController, [TweetViewModel], TwitterProfileViewModel) -> TweetTimelineViewController) {
        self.nav = nav
        self.errorFactory = errorFactory
        self.tweetTimelineFactory = tweetTimelineFactory
    }

    public func goToError() {
        nav.pushViewController(errorFactory(), animated: true)
    }

    public func goToTweetTimeline(nav: UINavigationController, tweetViewModel: [TweetViewModel], twitterViewModel: TwitterProfileViewModel) {
        nav.pushViewController(tweetTimelineFactory(nav, tweetViewModel, twitterViewModel), animated: true)
    }
}
