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
        let searchTwitterSpy = SearchTwitterSpy()
        let sut = makeSut(delegate: searchTwitterSpy)
        
        sut.searchTwitter(searchTwitterRequest: makeSearchTwitterRequest(userName: ""))
        
        XCTAssertEqual(searchTwitterSpy.errorMessage, "o campo nome do usuário é obrigatório")
    }

    func test_searchTwitter_should_call_showErrorMessage_when_twitterProfile_completes_with_unexpected() {
        let twitterProfile = TwitterProfileSpy()
        let searchTwitterSpy = SearchTwitterSpy()
        let sut = makeSut(twitterProfile: twitterProfile, delegate: searchTwitterSpy)
        
        sut.searchTwitter(searchTwitterRequest: makeSearchTwitterRequest())
        
        twitterProfile.completionWithError(.unexpected)
        
        XCTAssert(searchTwitterSpy.errorScreen)
    }

    func test_searchTwitter_should_call_showErrorMessage_when_twitterProfile_completes_with_invalidUserName() {
        let twitterProfile = TwitterProfileSpy()
        let searchTwitterSpy = SearchTwitterSpy()
        let sut = makeSut(twitterProfile: twitterProfile, delegate: searchTwitterSpy)
        
        sut.searchTwitter(searchTwitterRequest: makeSearchTwitterRequest())
        
        twitterProfile.completionWithError(.invalidUserName)
        
        XCTAssertEqual(searchTwitterSpy.errorMessage, "nome de usuário inválido")
    }
    
    func test_searchTwitter_should_call_showErrorMessage_when_twitterProfile_completes_with_userNameNotFound() {
        let twitterProfile = TwitterProfileSpy()
        let searchTwitterSpy = SearchTwitterSpy()
        let sut = makeSut(twitterProfile: twitterProfile, delegate: searchTwitterSpy)
        
        sut.searchTwitter(searchTwitterRequest: makeSearchTwitterRequest())
        
        twitterProfile.completionWithError(.userNameNotFound)
        
        XCTAssertEqual(searchTwitterSpy.errorMessage, "nome de usuário não encontrado")
    }

    func test_searchTwitter_should_call_tweetTimeline_when_twitterProfile_completes_with_success() {
        let twitterProfile = TwitterProfileSpy()
        let searchTwitterSpy = SearchTwitterSpy()
        let tweetTimelineSpy = TweetTimelineSpy()
        let sut = makeSut(twitterProfile: twitterProfile, tweetTimeLine: tweetTimelineSpy, delegate: searchTwitterSpy)
        
        sut.searchTwitter(searchTwitterRequest: makeSearchTwitterRequest())
        
        twitterProfile.completionWithSuccess(twitterProfileModel: makeTwitterProfileModel())
        
        XCTAssertEqual(tweetTimelineSpy.model, makeFetchTwitterTimeLine())
    }

    func test_fetchTweetTimeline_should_call_tweet_timeline_with_correct_values() {
        let tweetTimeline = TweetTimelineSpy()
        let sut = makeSut(tweetTimeLine: tweetTimeline)
        
        sut.fetchTweetTimeline(with: makeFetchTwitterTimeLine())
        
        XCTAssertEqual(tweetTimeline.model, makeFetchTwitterTimeLine())
    }
}

extension SearchTwitterPresentationTests {

    func makeSut(twitterProfile: TwitterProfile = TwitterProfileSpy(),
                 tweetTimeLine: TweetTimeline = TweetTimelineSpy(),
                 delegate: SearchTwitterDelegate = SearchTwitterSpy()) -> SearchTwitterPresentation {
        
        let sut = SearchTwitterPresentation(twitterProfile: twitterProfile, tweetTimeline: tweetTimeLine, delegate: delegate)
        return sut
    }

}
