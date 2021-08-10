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
    
    func showErrorMessage(_ errorMessage: String) {
        self.errorMessage = errorMessage
    }
    
    func showErrorScreen() {
        errorScreen = true
    }

    func goToTimeline(_ tweetViewModel: [TweetViewModel]) {
        self.tweetViewModel = tweetViewModel
    }
}
