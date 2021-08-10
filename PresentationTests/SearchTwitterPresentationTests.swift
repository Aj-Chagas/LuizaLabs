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
}

extension SearchTwitterPresentationTests {

    func makeSut(twitterProfile: TwitterProfile = TwitterProfileSpy(),
                 delegate: SearchTwitterDelegate = SearchTwitterSpy()) -> SearchTwitterPresentation {
        
        let sut = SearchTwitterPresentation(twitterProfile: twitterProfile, delegate: delegate)
        return sut
    }

    func makeSearchTwitterRequest(userName: String = "any_name") -> SearchTwitterRequest {
        SearchTwitterRequest(userName: userName)
    }

}

class SearchTwitterSpy: SearchTwitterDelegate {
    var errorMessage: String?
    var errorScreen: Bool = false
    
    func showErrorMessage(_ errorMessage: String) {
        self.errorMessage = errorMessage
    }
    
    func showErrorScreen() {
        errorScreen = true
    }
}

class TwitterProfileSpy: TwitterProfile {

    var fetchTwitterProfileModel: FetchTwitterProfileModel?
    var completion: ((TwitterProfile.Result) -> Void)?
    
    func fetchTwitterProfile(fetchTwitterProfileModel: FetchTwitterProfileModel, completion: @escaping (TwitterProfile.Result) -> Void) {
        self.fetchTwitterProfileModel = fetchTwitterProfileModel
        self.completion = completion
    }
    
    func completionWithError(_ error: DomainError = .unexpected){
        completion?(.failure(error))
    }
    
    func completionWithSuccess(twitterProfileModel model: TwitterProfileModel) {
        completion?(.success(model))
    }

}
