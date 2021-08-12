//
//  TweetTimelineRouterFactory.swift
//  Main
//
//  Created by Anderson Chagas on 11/08/21.
//

import UI
import UIKit

private let errorFactory: () -> ErrorGenericViewController = {
    return ErrorGenericViewController.instantiate()
}

func makeTweetTimelineRouter(nav: UINavigationController) -> TweetTimelineRouter {
    TweetTimelineRouter(nav: nav, errorFactory: errorFactory)
}
