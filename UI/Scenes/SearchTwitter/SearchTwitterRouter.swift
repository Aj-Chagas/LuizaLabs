//
//  SearchTwitterRouter.swift
//  UI
//
//  Created by Anderson Chagas on 11/08/21.
//

import UIKit

public final class SearchTwitterRouter {
    private let nav: UINavigationController
    private let errorFactory: () -> ErrorGenericViewController
    private let tweetTimelineFactory: () -> TweetTimelineViewController

    public init(nav: UINavigationController,
                errorFactory: @escaping () -> ErrorGenericViewController,
                tweetTimelineFactory: @escaping () -> TweetTimelineViewController) {
        self.nav = nav
        self.errorFactory = errorFactory
        self.tweetTimelineFactory = tweetTimelineFactory
    }

    public func goToError() {
        nav.pushViewController(errorFactory(), animated: true)
    }

    public func goToTweetTimeline() {
        nav.pushViewController(tweetTimelineFactory(), animated: true)
    }
}
