//
//  SearchTwitterPresentationTests.swift
//  PresentationTests
//
//  Created by Anderson Chagas on 09/08/21.
//

import XCTest
import Presentation
import Domain

class SearchTwitterPresentationTests: XCTestCase {

    func test_searchTwitter_should_call_twitter_profile_with_correct_values() {
        let twitterProfile = TwitterProfileSpy()
        let sut = makeSut(twitterProfile: twitterProfile)
        
        sut.searchTwitter(searchTwitterRequest: makeSearchTwitterRequest())
        
        XCTAssertEqual(twitterProfile.fetchTwitterProfileModel, makeFetchTwitterProfileModel())
    }
    
    func test_searchTwitter_should_call_showErrorMessage_when_userName_is_empty() {
        let searchTwitterSpy = SearchTwitterDelegateSpy()
        let sut = makeSut(delegate: searchTwitterSpy)
        
        sut.searchTwitter(searchTwitterRequest: makeSearchTwitterRequest(userName: ""))
        
        XCTAssertEqual(searchTwitterSpy.errorMessage, "o campo nome do usuário é obrigatório")
    }

    func test_searchTwitter_should_call_showErrorMessage_when_twitterProfile_completes_with_unexpected() {
        let twitterProfile = TwitterProfileSpy()
        let searchTwitterSpy = SearchTwitterDelegateSpy()
        let sut = makeSut(twitterProfile: twitterProfile, delegate: searchTwitterSpy)
        
        sut.searchTwitter(searchTwitterRequest: makeSearchTwitterRequest())
        
        twitterProfile.completionWithError(.unexpected)
        
        XCTAssert(searchTwitterSpy.errorScreen)
    }

    func test_searchTwitter_should_should_show_loading_before_and_after_twitterProfile() {
        let twitterProfile = TwitterProfileSpy()
        let loadingView = LoadingViewSpy()
        let searchTwitterSpy = SearchTwitterDelegateSpy()
        let sut = makeSut(twitterProfile: twitterProfile, delegate: searchTwitterSpy, loadingView: loadingView)

        XCTContext.runActivity(named: "before calls twitterProfile isLoading should be true") { _ in
            let exp = expectation(description: "waiting")
            loadingView.observer { viewModel in
                XCTAssertEqual(viewModel, LoadingViewModel(isLoading: true))
                exp.fulfill()
            }
            sut.searchTwitter(searchTwitterRequest: makeSearchTwitterRequest())
            wait(for: [exp], timeout: 1)
        }

        XCTContext.runActivity(named: "after calls twitterProfile with failure isLoading should be false") { _ in
            let exp1 = expectation(description: "waiting")
            loadingView.observer { viewModel in
                XCTAssertEqual(viewModel, LoadingViewModel(isLoading: false))
                exp1.fulfill()
            }
            
            twitterProfile.completionWithError()
            wait(for: [exp1], timeout: 1)
        }
    }

    func test_searchTwitter_should_call_showErrorMessage_when_twitterProfile_completes_with_invalidUserName() {
        let twitterProfile = TwitterProfileSpy()
        let searchTwitterSpy = SearchTwitterDelegateSpy()
        let sut = makeSut(twitterProfile: twitterProfile, delegate: searchTwitterSpy)
        
        sut.searchTwitter(searchTwitterRequest: makeSearchTwitterRequest())
        
        twitterProfile.completionWithError(.invalidUserName)
        
        XCTAssertEqual(searchTwitterSpy.errorMessage, "nome de usuário inválido")
    }
    
    func test_searchTwitter_should_call_showErrorMessage_when_twitterProfile_completes_with_userNameNotFound() {
        let twitterProfile = TwitterProfileSpy()
        let searchTwitterSpy = SearchTwitterDelegateSpy()
        let sut = makeSut(twitterProfile: twitterProfile, delegate: searchTwitterSpy)
        
        sut.searchTwitter(searchTwitterRequest: makeSearchTwitterRequest())
        
        twitterProfile.completionWithError(.userNameNotFound)
        
        XCTAssertEqual(searchTwitterSpy.errorMessage, "nome de usuário não encontrado")
    }

    func test_searchTwitter_should_call_tweetTimeline_when_twitterProfile_completes_with_success() {
        let twitterProfile = TwitterProfileSpy()
        let searchTwitterSpy = SearchTwitterDelegateSpy()
        let tweetTimelineSpy = TweetTimelineSpy()
        let sut = makeSut(twitterProfile: twitterProfile, tweetTimeLine: tweetTimelineSpy, delegate: searchTwitterSpy)
        
        sut.searchTwitter(searchTwitterRequest: makeSearchTwitterRequest())
        
        twitterProfile.completionWithSuccess(twitterProfileModel: makeTwitterProfileModel())
        
        XCTAssertEqual(tweetTimelineSpy.model, makeFetchTwitterTimeLine())
    }

    func test_fetchTweetTimeline_should_call_tweet_timeline_with_correct_values() {
        let tweetTimeline = TweetTimelineSpy()
        let sut = makeSut(tweetTimeLine: tweetTimeline)
        
        sut.fetchTweetTimeline(with: makeTwitterProfileViewModel())
        
        XCTAssertEqual(tweetTimeline.model, makeFetchTwitterTimeLine())
    }

    func test_fetchTweetTimeline_should_call_showErrorScreen_when_tweetTimeline_completes_with_fails() {
        let tweetTimeline = TweetTimelineSpy()
        let searchTwitterSpy = SearchTwitterDelegateSpy()
        let sut = makeSut(tweetTimeLine: tweetTimeline, delegate: searchTwitterSpy)
        
        sut.fetchTweetTimeline(with: makeTwitterProfileViewModel())
        
        tweetTimeline.completionWithError(.unexpected)
        
        XCTAssert(searchTwitterSpy.errorScreen)
    }

    func test_fetchTweetTimeline_should_call_goToTimeline_when_tweetTimeline_completes_with_success() {
        let tweetTimeline = TweetTimelineSpy()
        let searchTwitterSpy = SearchTwitterDelegateSpy()
        let sut = makeSut(tweetTimeLine: tweetTimeline, delegate: searchTwitterSpy)
        
        sut.fetchTweetTimeline(with: makeTwitterProfileViewModel())
        
        tweetTimeline.completionWithSuccess(twitterTimeline: makeTweetTimelineModel())
        
        XCTAssertEqual(searchTwitterSpy.tweetViewModel, makeTweetViewModel())
    }

    func test_fetchTweetTimeline_should_should_hidden_loading_TweetTimeline() {
        let tweetTimeline = TweetTimelineSpy()
        let loadingView = LoadingViewSpy()
        let searchTwitterSpy = SearchTwitterDelegateSpy()
        let sut = makeSut(tweetTimeLine: tweetTimeline, delegate: searchTwitterSpy, loadingView: loadingView)

        XCTContext.runActivity(named: "after calls TweetTimeline isLoading should be false") { _ in
            let exp = expectation(description: "waiting")
            loadingView.observer { viewModel in
                XCTAssertEqual(viewModel, LoadingViewModel(isLoading: false))
                exp.fulfill()
            }
            sut.fetchTweetTimeline(with: makeTwitterProfileViewModel())
            
            tweetTimeline.completionWithError()
            wait(for: [exp], timeout: 1)
        }

    }
}

extension SearchTwitterPresentationTests {

    func makeSut(twitterProfile: TwitterProfile = TwitterProfileSpy(),
                 tweetTimeLine: TweetTimeline = TweetTimelineSpy(),
                 delegate: SearchTwitterDelegate = SearchTwitterDelegateSpy(),
                 loadingView: LoadingView = LoadingViewSpy(),
                 file: StaticString = #filePath, line: UInt = #line) -> SearchTwitterPresentation {
        
        let sut = SearchTwitterPresentation(twitterProfile: twitterProfile, tweetTimeline: tweetTimeLine, delegate: delegate, loadingView: loadingView)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }

}
