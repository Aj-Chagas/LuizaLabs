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
        let sut = SearchTwitterPresentation(twitterProfile: twitterProfile, delegate: SearchTwitterSpy())
        
        sut.seachTwitter(searchTwitterRequest: makeSearchTwitterRequest())
        
        XCTAssertEqual(twitterProfile.fetchTwitterProfileModel, makeFetchTwitterProfileModel())
    }
    
    func test_searchTwitter_should_call_showErrorMessage_when_userName_is_empty() {
        let twitterProfile = TwitterProfileSpy()
        let searchTwitterSpy = SearchTwitterSpy()
        let sut = SearchTwitterPresentation(twitterProfile: twitterProfile, delegate: searchTwitterSpy)
        
        sut.seachTwitter(searchTwitterRequest: makeSearchTwitterRequest(userName: ""))
        
        XCTAssertEqual(searchTwitterSpy.errorMessage, "o campo nome do usuário é obrigatório")
    }
}

extension SearchTwitterPresentationTests {
    func makeSearchTwitterRequest(userName: String = "any_name") -> SearchTwitterRequest {
        SearchTwitterRequest(userName: userName)
    }
    
}

class SearchTwitterSpy: SearchTwitterDelegate {
    var errorMessage: String?
    
    func showErrorMessage(_ errorMessage: String) {
        self.errorMessage = errorMessage
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
