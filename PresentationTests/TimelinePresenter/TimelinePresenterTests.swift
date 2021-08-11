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

    func test_analyzeSentiment_should_call_handlerError_when_analyzeSentiment_completes_with_failure() {
        let analyzeSentiment = AnalyzeSentimentSpy()
        let delegate = TimelineDelegateSpy()
        let model = makeFetchAnalyzeSentimentModel()
        let sut = makeSut(analyzeSentiment: analyzeSentiment, delegate: delegate)
        
        sut.analyzeSentiment(with: model)
        
        analyzeSentiment.completionWithError()
        
        XCTAssert(delegate.error)
    }

    func test_analyzeSentiment_should_call_handlerSuccess_when_analyzeSentiment_completes_with_success() {
        let analyzeSentiment = AnalyzeSentimentSpy()
        let delegate = TimelineDelegateSpy()
        let model = makeAnalyzeSentimentModel()
        let sut = makeSut(analyzeSentiment: analyzeSentiment, delegate: delegate)
        
        sut.analyzeSentiment(with: makeFetchAnalyzeSentimentModel())
        
        analyzeSentiment.completionWithSuccess(model)
        
        XCTAssertEqual(delegate.viewmodel, AnalyzeSentimentViewModel(analyzeSentiment: model))
    }
}

extension TimelinePresenterTests {
    func makeSut(analyzeSentiment: AnalyzeSentiment = AnalyzeSentimentSpy(),
                 delegate: TimelineDelegate = TimelineDelegateSpy()) -> TimelinePresenter {
        let sut = TimelinePresenter(analyzeSentiment: analyzeSentiment, delegate: delegate)
        checkMemoryLeak(for: sut)
        return sut
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
    
    func completionWithSuccess(_ model: AnalyzeSentimentModel) {
        completion?(.success(model))
    }

}

class TimelineDelegateSpy: TimelineDelegate {

    var error: Bool = false
    var viewmodel: AnalyzeSentimentViewModel?

    func handlerError() {
        self.error = true
    }
    
    func handlerSuccess(viewmodel: AnalyzeSentimentViewModel) {
        self.viewmodel = viewmodel
    }

}


