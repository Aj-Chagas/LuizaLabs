//
//  SearchTwitterDelegateSpy.swift
//  PresentationTests
//
//  Created by Anderson Chagas on 09/08/21.
//

import Foundation
import Presentation
import Domain

class SearchTwitterDelegateSpy: SearchTwitterDelegate {
    var errorMessage: String?
    var errorScreen: Bool = false
    var tweetViewModel: [TweetViewModel]?
    var twitterProfileViewModel: TwitterProfileViewModel?
    
    func showErrorMessage(_ errorMessage: String) {
        self.errorMessage = errorMessage
    }
    
    func showErrorScreen() {
        errorScreen = true
    }

    func goToTimeline(_ tweetTimelineViewModel: [TweetViewModel], _ twitterProfileViewModel: TwitterProfileViewModel) {
        self.tweetViewModel = tweetTimelineViewModel
        self.twitterProfileViewModel = twitterProfileViewModel
    }
}
