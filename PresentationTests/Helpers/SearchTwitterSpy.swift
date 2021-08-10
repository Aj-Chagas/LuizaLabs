//
//  SearchTwitterSpy.swift
//  PresentationTests
//
//  Created by Anderson Chagas on 09/08/21.
//

import Foundation
import Presentation
import Domain

class SearchTwitterSpy: SearchTwitterDelegate {
    var errorMessage: String?
    var errorScreen: Bool = false
    var tweetTimelineModel: TweetTimelineModel?
    
    func showErrorMessage(_ errorMessage: String) {
        self.errorMessage = errorMessage
    }
    
    func showErrorScreen() {
        errorScreen = true
    }

    func goToTimeline(_ tweetTimelineModel: TweetTimelineModel) {
        self.tweetTimelineModel = tweetTimelineModel
    }
}
