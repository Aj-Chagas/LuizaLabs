//
//  TweetTimelineRouter.swift
//  UI
//
//  Created by Anderson Chagas on 11/08/21.
//

import UIKit

public final class TweetTimelineRouter {
    private let nav: UINavigationController
    private let errorFactory: () -> ErrorGenericViewController

    public init(nav: UINavigationController,
                errorFactory: @escaping () -> ErrorGenericViewController) {
        self.nav = nav
        self.errorFactory = errorFactory
    }

    public func goToError() {
        nav.pushViewController(errorFactory(), animated: true)
    }
}
