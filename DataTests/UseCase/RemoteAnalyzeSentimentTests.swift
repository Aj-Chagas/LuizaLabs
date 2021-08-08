//
//  RemoteAnalyzeSentimentTests.swift
//  DataTests
//
//  Created by Anderson Chagas on 08/08/21.
//

import XCTest
import Data
import Domain

class RemoteAnalyzeSentimentTests: XCTestCase {
    func test_fetchTweetTimeLine_should_call_httpGetClient_with_correct_params() {
        let httpClient = HttpPostClientSpy()
        let model = makeFetchAnalyzeSentimentModel()
        let url = makeUrl()
        let sut = makeSut(url: url, httpPostClient: httpClient)
        
        // When
        sut.fetchAnalyzeSentiment(fetchTweetTimeLineModel: model) { _ in }
        
        // Then
        XCTAssertEqual(httpClient.urls, [url])
    }
    
    func test_fetchAnalyzeSentiment_should_complete_with_error_if_client_completes_with_error() {
        let httpPostClient = HttpPostClientSpy()
        let sut = makeSut(httpPostClient: httpPostClient)

        expect(sut, expectedResult: .failure(.unexpected), when: {
            httpPostClient.completionWithError()
        })
    }
    
    func test_fetchAnalyzeSentiment_should_complete_with_success_if_client_completes_with_valid_data() {
        let httpPostClient = HttpPostClientSpy()
        let sut = makeSut(httpPostClient: httpPostClient)
        let model = makeAnalyzeSentimentModel()
        
        expect(sut, expectedResult: .success(model), when: {
            httpPostClient.completionWithSuccess(model.toData())
        })
    }

    func test_fetchAnalyzeSentiment_should_complete_with_error_if_client_with_invalid_data() {
        let httpPostClient = HttpPostClientSpy()
        let sut = makeSut(httpPostClient: httpPostClient)
        
        expect(sut, expectedResult: .failure(.unexpected), when: {
            httpPostClient.completionWithSuccess(makeInvalidData())
        })
    }
}

extension RemoteAnalyzeSentimentTests {
    func makeSut(url: URL = makeUrl(),
                 httpPostClient: HttpPostClient) -> RemoteAnalyzeSentiment {
        let sut = RemoteAnalyzeSentiment(url: url, httpPostClient: httpPostClient)
        checkMemoryLeak(for: sut)
        return sut
    }
    
    func expect(_ sut: RemoteAnalyzeSentiment,
                expectedResult: AnalyzeSentiment.Result,
                when action: () -> Void = { _ = (() -> Void).self },
                model: FetchAnalyzeSentimentModel = makeFetchAnalyzeSentimentModel(),
                file: StaticString = #filePath,
                line: UInt = #line) {
        
        let exp = expectation(description: "waiting")
        sut.fetchAnalyzeSentiment(fetchTweetTimeLineModel: model) { receivedResult in
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
