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
        let model = makeTimelineRequest()
        let sut = makeSut(analyzeSentiment: analyzeSentiment)
        
        sut.analyzeSentiment(with: model)
        
        XCTAssertEqual(analyzeSentiment.model, model.toFetchAnalyzeSentimentModel())
    }

    func test_analyzeSentiment_should_call_handlerError_when_analyzeSentiment_completes_with_failure() {
        let analyzeSentiment = AnalyzeSentimentSpy()
        let delegate = TimelineDelegateSpy()
        let model = makeTimelineRequest()
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
        
        sut.analyzeSentiment(with: makeTimelineRequest())
        
        analyzeSentiment.completionWithSuccess(model)
        
        XCTAssertEqual(delegate.viewmodel, AnalyzeSentimentViewModel(analyzeSentiment: model))
    }

    func test_analyzeSentiment_should_should_show_loading_before_and_after_analyzeSentiment() {

        let analyzeSentiment = AnalyzeSentimentSpy()
        let delegate = TimelineDelegateSpy()
        let loadingView = LoadingViewSpy()
        let sut = makeSut(analyzeSentiment: analyzeSentiment, loadingView: loadingView, delegate: delegate)

        XCTContext.runActivity(named: "before calls analyzeSentiment isLoading should be true") { _ in
            let exp = expectation(description: "waiting")
            loadingView.observer { viewModel in
                XCTAssertEqual(viewModel, LoadingViewModel(isLoading: true))
                exp.fulfill()
            }
            sut.analyzeSentiment(with: makeTimelineRequest())
            wait(for: [exp], timeout: 1)
        }

        XCTContext.runActivity(named: "after calls analyzeSentiment with failure isLoading should be false") { _ in
            let exp1 = expectation(description: "waiting")
            loadingView.observer { viewModel in
                XCTAssertEqual(viewModel, LoadingViewModel(isLoading: false))
                exp1.fulfill()
            }
            
            analyzeSentiment.completionWithError()
            wait(for: [exp1], timeout: 1)
        }
    }
}

extension TimelinePresenterTests {
    func makeSut(analyzeSentiment: AnalyzeSentiment = AnalyzeSentimentSpy(),
                 loadingView: LoadingView = LoadingViewSpy(),
                 delegate: TimelineDelegate = TimelineDelegateSpy()) -> TimelinePresenter {
        let sut = TimelinePresenter(analyzeSentiment: analyzeSentiment,
                                    loadingView: loadingView, delegate: delegate)
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


