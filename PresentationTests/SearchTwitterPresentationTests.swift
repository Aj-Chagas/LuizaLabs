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

    func test_seachTwitter_should_call_twitter_profile_with_correct_values() {
        let twitterProfile = TwitterProfileSpy()
        let sut = SearchTwitterPresentation(twitterProfile: twitterProfile)
        
        sut.seachTwitter(searchTwitterRequest: makeSearchTwitterRequest())
        
        XCTAssertEqual(twitterProfile.fetchTwitterProfileModel, makeFetchTwitterProfileModel())
    }
}

extension SearchTwitterPresentationTests {
    func makeSearchTwitterRequest() -> SearchTwitterRequest {
        SearchTwitterRequest(userName: "any_name")
    }
}

class TwitterProfileSpy: TwitterProfile {

    var fetchTwitterProfileModel: FetchTwitterProfileModel?
    var completion: ((TwitterProfile.Result) -> Void)?
    
    func fetchTwitterProfile(fetchTwitterProfileModel: FetchTwitterProfileModel, completion: @escaping (TwitterProfile.Result) -> Void) {
        self.fetchTwitterProfileModel = fetchTwitterProfileModel
        self.completion = completion
    }
    
    func completionWithErro(_ error: DomainError = .unexpected){
        completion?(.failure(error))
    }
    
    func completionWithSuccess(twitterProfileModel model: TwitterProfileModel) {
        completion?(.success(model))
    }

}
