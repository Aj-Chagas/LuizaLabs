//
//  ConclusionFactory.swift
//  Main
//
//  Created by Anderson Chagas on 11/08/21.
//

import Foundation
import UI
import Presentation

public func makeConclusionFactory(tweet: String,
                                  analyzeSentimentViewModel: AnalyzeSentimentViewModel) -> ConclusionViewController {
    let controller = ConclusionViewController.instantiate()
    let presenter = ConclusionPresenter()
    
    controller.tweet = tweet
    controller.analyzeSentimentViewModel = analyzeSentimentViewModel
    
    controller.calculateSentiment = presenter.calculateSentiment
    
    return controller
}

