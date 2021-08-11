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

private let errorFactory: () -> ErrorGenericViewController = {
    return ErrorGenericViewController.instantiate()
}

private let tweetTimelineController: () -> TweetTimelineViewController = {
    return TweetTimelineViewController.instantiate()
}

public func makeSearchTwitterFactory(router: SearchTwitterRouter) -> SearchTwitterViewController {
    let controller = SearchTwitterViewController.instantiate()
    let httpClient = AlamofireAdapter()
    let twitterProfile = RemoteTwitterProfile(url: URL(string: "https://api.twitter.com/2/users/by/username/")!, httpGetClient: httpClient, header: ["Authorization": "Bearer AAAAAAAAAAAAAAAAAAAAAI7RSQEAAAAA6Xlma4v%2FZ%2BZ7pvlPE3rmOVkCias%3Dszrq8Ililogdj7Wh91OmYWyDjjQS3ftOpYBKBAgEVTjPjbCmS4"])
    let tweetTimeline = RemoteTweetTimeline(url: URL(string: "https://api.twitter.com/2/users/:id/tweets")!, httpGetClient: httpClient, header: ["Authorization": "Bearer AAAAAAAAAAAAAAAAAAAAAI7RSQEAAAAA6Xlma4v%2FZ%2BZ7pvlPE3rmOVkCias%3Dszrq8Ililogdj7Wh91OmYWyDjjQS3ftOpYBKBAgEVTjPjbCmS4"])
    let presenter = SearchTwitterPresenter(twitterProfile: twitterProfile, tweetTimeline: tweetTimeline, delegate: controller, loadingView: controller)
    controller.searchTwitter = presenter.searchTwitter

    controller.errorFactory = router.goToError
    controller.tweetTimelineFactory = router.goToTweetTimeline
    return controller
}

func makeSearchTwitterRouter(nav: UINavigationController) -> SearchTwitterRouter {
    SearchTwitterRouter(nav: nav, errorFactory: errorFactory, tweetTimelineFactory: tweetTimelineController)
}
