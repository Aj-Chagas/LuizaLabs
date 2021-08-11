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
    func test_analyzeSentiment_should_call_twitter_profile_with_correct_values() {
        let analyzeSentiment = AnalyzeSentimentSpy()
        let model = makeFetchAnalyzeSentimentModel()
        let sut = makeSut(analyzeSentiment: analyzeSentiment)
        
        sut.analyzeSentiment(with: model)
        
        XCTAssertEqual(analyzeSentiment.model, model)
    }

    func test_analyzeSentiment_should_call_showErrorScreen_when_analyzeSentiment_completes_with_failure() {
        let analyzeSentiment = AnalyzeSentimentSpy()
        let delegate = TimelineDelegateSpy()
        let model = makeFetchAnalyzeSentimentModel()
        let sut = makeSut(analyzeSentiment: analyzeSentiment, delegate: delegate)
        
        sut.analyzeSentiment(with: model)
        
        analyzeSentiment.completionWithError()
        
        XCTAssert(delegate.screenError)
    }
}

extension TimelinePresenterTests {
    func makeSut(analyzeSentiment: AnalyzeSentiment = AnalyzeSentimentSpy(),
                 delegate: TimelineDelegate = TimelineDelegateSpy()) -> TimelinePresenter {
        return TimelinePresenter(analyzeSentiment: analyzeSentiment, delegate: delegate)
    }
}

class AnalyzeSentimentSpy: AnalyzeSentiment {

    var model: FetchAnalyzeSentimentModel?
    var completion: ((AnalyzeSentiment.Result) -> Void)?

    func fetchAnalyzeSentiment(fetchTweetTimeLineModel model: FetchAnalyzeSentimentModel, completion: @escaping (AnalyzeSentiment.Result) -> Void) {
        self.model = model
        self.completion = completion
    }

    func completionWithError(_ error: DomainError = .unexpected) {
        completion?(.failure(.unexpected))
    }

}

class TimelineDelegateSpy: TimelineDelegate {

    var screenError: Bool = false

    func showErrorScreen() {
        screenError = true
    }

}


