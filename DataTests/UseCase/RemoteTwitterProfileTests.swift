//
//  DataTests.swift
//  DataTests
//
//  Created by Anderson Chagas on 07/08/21.
//

import XCTest
import Domain
import Data

class RemoteTwitterProfileTests: XCTestCase {

    func test_fetchTwitterProfile_should_call_httpGetClient_with_correct_params() {
        let httpClient = HttpClientSpy()
        let model = makeFetchTwitterProfileModel()
        let url = makeUrl()
        let sut = makeSut(url: url, httpGetClient: httpClient)
        let expectedUrl = URL(string: "http://any-url.com/any_name")
        
        // When
        sut.fetchTwitterProfile(fetchTwitterProfileModel: model) { _ in }
        
        // Then
        XCTAssertEqual(httpClient.urls, [expectedUrl])
    }

    func test_fetchTwitterProfile_should_complete_with_error_if_client_completes_with_error() {
        let httpGetClient = HttpClientSpy()
        let sut = makeSut(httpGetClient: httpGetClient)

        expect(sut, expectedResult: .failure(.unexpected), when: {
            httpGetClient.completionWithError()
        })

    }

    func test_fetchTwitterProfile_should_complete_with_success_if_client_with_valid_data() {
        let httpGetClient = HttpClientSpy()
        let sut = makeSut(httpGetClient: httpGetClient)
        let model = makeTwitterProfileModel()
        
        expect(sut, expectedResult: .success(model), when: {
            httpGetClient.completionWithSuccess(model.toData())
        })
    }

    func test_fetchTwitterProfile_should_complete_with_error_if_client_with_invalid_data() {
        let httpGetClient = HttpClientSpy()
        let sut = makeSut(httpGetClient: httpGetClient)
        
        expect(sut, expectedResult: .failure(.userNameNotFound), when: {
            httpGetClient.completionWithSuccess(makeInvalidData())
        })
    }

    func test_makeTwitterProfileUrl_should_return_complete_url_with_correct_path() {
        let url = makeUrl()
        let model = makeFetchTwitterProfileModel()
        let sut = makeSut(url: url)
        
        let completeUrl = sut.makeTwitterProfileUrl(model) { _ in }
        
        let expectedUrl = URL(string: "http://any-url.com/any_name")
        
        XCTAssertEqual(completeUrl, expectedUrl)
    }

    func test_makeTwitterProfileUrl_should_return_url_without_path_when_path_is_invalid() {
        let url = makeUrl()
        let model = makeInvalidFetchTwitterProfileModel()
        let sut = makeSut(url: url)
        
        let completeUrl = sut.makeTwitterProfileUrl(model) { _ in }
        
        XCTAssertEqual(completeUrl, url)
    }
    
    func test_makeTwitterProfileUrl_should_completes_with_invalidaUserName_when_userName_is_invalid() {
        let url = makeUrl()
        let model = makeInvalidFetchTwitterProfileModel()
        let sut = makeSut(url: url)
        
        expect(sut, expectedResult: .failure(.invalidUserName), model: model)
    }

}

extension RemoteTwitterProfileTests {
    func makeSut(url: URL = makeUrl(),
                 httpGetClient: HttpClient = HttpClientSpy(),
                 file: StaticString = #filePath,
                 line: UInt = #line) -> RemoteTwitterProfile {
        let sut = RemoteTwitterProfile(url: url, httpGetClient: httpGetClient, header: makeHeader())
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
    
    func expect(_ sut: RemoteTwitterProfile,
                expectedResult: TwitterProfile.Result,
                when action: () -> Void = { _ = (() -> Void).self },
                model: FetchTwitterProfileModel = makeFetchTwitterProfileModel(),
                file: StaticString = #filePath,
                line: UInt = #line) {
        
        let exp = expectation(description: "waiting")
        sut.fetchTwitterProfile(fetchTwitterProfileModel: model) { receivedResult in
            switch (expectedResult, receivedResult) {
            case (.failure(let expectedError), .failure(let receivedError)):
                XCTAssertEqual(expectedError, receivedError, file: file, line: line)
            case (.success(let expectedTwitterProfile), .success(let receivedTwitterProfile)):
                XCTAssertEqual(expectedTwitterProfile, receivedTwitterProfile, file: file, line: line)
            default:
                XCTFail("Expected \(expectedResult) received \(receivedResult) instead")
            }
            exp.fulfill()
        }
        action()
        wait(for: [exp], timeout: 1)
    }
    
}
