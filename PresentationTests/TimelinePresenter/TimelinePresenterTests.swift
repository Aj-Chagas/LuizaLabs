//
//  TimelinePresenterTests.swift
//  PresentationTests
//
//  Created by Anderson Chagas on 10/08/21.
//

import XCTest
import Domain
import Presentation

class TimelinePresenterTests: XCTestCase {
    func test_searchTwitter_should_call_twitter_profile_with_correct_values() {
        let analyzeSentiment = AnalyzeSentimentSpy()
        let model = makeFetchAnalyzeSentimentModel()
        let sut = TimelinePresenter(analyzeSentiment: analyzeSentiment)
        
        sut.analyzeSentiment(with: model)
        
        XCTAssertEqual(analyzeSentiment.model, model)
    }
}

class AnalyzeSentimentSpy: AnalyzeSentiment {
    
    var model: FetchAnalyzeSentimentModel?
    var completion: ((AnalyzeSentiment.Result) -> Void)?
    
    
    func fetchAnalyzeSentiment(fetchTweetTimeLineModel model: FetchAnalyzeSentimentModel, completion: @escaping (AnalyzeSentiment.Result) -> Void) {
        self.model = model
        self.completion = completion
    }
    
}


