//
//  TweetTimelineRouter.swift
//  UI
//
//  Created by Anderson Chagas on 11/08/21.
//

import UIKit
import Presentation

public final class TweetTimelineRouter {
    private let nav: UINavigationController
    private let errorFactory: () -> ErrorGenericViewController
    private let conclusionFactory: (_ tweet: String, _ sentimentViewModel: AnalyzeSentimentViewModel) -> ConclusionViewController

    public init(nav: UINavigationController,
                errorFactory: @escaping () -> ErrorGenericViewController,
                conclusionFactory: @escaping (_ tweet: String, _ sentimentViewModel: AnalyzeSentimentViewModel) -> ConclusionViewController) {
        self.nav = nav
        self.errorFactory = errorFactory
        self.conclusionFactory = conclusionFactory
    }

    public func goToError() {
        nav.pushViewController(errorFactory(), animated: true)
    }
    
    public func goToConclusion(tweet: String, sentimentViewModel: AnalyzeSentimentViewModel) {
        nav.pushViewController(conclusionFactory(tweet, sentimentViewModel), animated: true)
    }
}
