//
//  SceneDelegate.swift
//  Main
//
//  Created by Anderson Chagas on 11/08/21.
//

import UIKit
import UI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    private let errorFactory: () -> ErrorGenericViewController = {
        return ErrorGenericViewController.instantiate()
    }

    private let tweetTimelineController: () -> TweetTimelineViewController = {
        return TweetTimelineViewController.instantiate()
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)

        let controller = SearchTwitterViewController.instantiate()
        let nav = UINavigationController(rootViewController: controller)
        
        let searchTwitterRouter = SearchTwitterRouter(nav: nav, errorFactory: errorFactory, tweetTimelineFactory: tweetTimelineController)
        
        controller.errorFactory = searchTwitterRouter.goToError
        controller.tweetTimelineFactory = searchTwitterRouter.goToTweetTimeline

        window?.rootViewController = nav
        window?.makeKeyAndVisible()
    }

}

