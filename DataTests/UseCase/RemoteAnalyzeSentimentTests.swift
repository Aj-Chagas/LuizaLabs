//
//  RemoteAnalyzeSentimentTests.swift
//  DataTests
//
//  Created by Anderson Chagas on 08/08/21.
//

import XCTest
import Data

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
}

extension RemoteAnalyzeSentimentTests {
    func makeSut(url: URL = makeUrl(),
                 httpPostClient: HttpPostClient) -> RemoteAnalyzeSentiment {
        let sut = RemoteAnalyzeSentiment(url: url, httpPostClient: httpPostClient)
        checkMemoryLeak(for: sut)
        return sut
    }
}
