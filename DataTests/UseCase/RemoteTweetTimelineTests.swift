//
//  RemoteTweetTimelineTests.swift
//  DataTests
//
//  Created by Anderson Chagas on 08/08/21.
//

import XCTest
import Data
import Domain

class RemoteTweetTimelineTests: XCTestCase {
    func test_fetchTweetTimeLine_should_call_httpGetClient_with_correct_params() {
        let httpClient = HttpGetClientSpy()
        let model = makeFetchTwitterTimeLine()
        let url = makeUrl()
        let params = makeParams()
        let header = makeHeader()
        let sut = makeSut(url: url, httpGetClient: httpClient, params: params, header: header)
        
        // When
        sut.fetchTweetTimeLine(fetchTweetTimeLineModel: model) { _ in }
        
        // Then
        XCTAssertEqual(httpClient.urls, [URL(string: "http://any-url.com/any_id")])
        XCTAssertEqual(httpClient.headers, header)
        XCTAssertEqual(httpClient.params as! [String: Int], params as! [String: Int])
    }
    
    func test_fetchTweetTimeLine_should_complete_with_error_if_client_completes_with_error() {
        let httpGetClient = HttpGetClientSpy()
        let sut = makeSut(httpGetClient: httpGetClient)

        expect(sut, expectedResult: .failure(.unexpected), when: {
            httpGetClient.completionWithError()
        })
    }
    
    func test_fetchTweetTimeLine_should_complete_with_success_if_client_with_valid_data() {
        let httpGetClient = HttpGetClientSpy()
        let sut = makeSut(httpGetClient: httpGetClient)
        let model = makeTweetTimelineModel()
        
        expect(sut, expectedResult: .success(model), when: {
            httpGetClient.completionWithSuccess(model.toData())
        })
    }

    func test_fetchTweetTimeLine_should_complete_with_error_if_client_with_invalid_data() {
        let httpGetClient = HttpGetClientSpy()
        let sut = makeSut(httpGetClient: httpGetClient)
        
        expect(sut, expectedResult: .failure(.unexpected), when: {
            httpGetClient.completionWithSuccess(makeInvalidData())
        })
    }
    
    func test_makeTweetTimeLineUrl_should_return_complete_url_with_correct_path() {
        let url = makeUrl()
        let model = makeFetchTwitterTimeLine()
        let sut = makeSut(url: url)
        
        let completeUrl = sut.makeTweetTimeLineUrl(model)
        
        let expectedUrl = URL(string: "http://any-url.com/any_id")
        
        XCTAssertEqual(completeUrl, expectedUrl)
    }

    func test_makeTweetTimeLineUrl_should_return_url_without_path_when_path_is_invalid() {
        let url = makeUrl()
        let model = makeInvalidFetchTwitterTimeLine()
        let sut = makeSut(url: url)
        
        let completeUrl = sut.makeTweetTimeLineUrl(model)
        
        XCTAssertEqual(completeUrl, url)
    }
    
}

extension RemoteTweetTimelineTests {
    func makeSut(url: URL = makeUrl(),
                 httpGetClient: HttpGetClient = HttpGetClientSpy(),
                 params: [String: Any] = makeParams(),
                 header: [String: String] = makeHeader(),
                 file: StaticString = #filePath,
                 line: UInt = #line) -> RemoteTweetTimeline {
        let sut = RemoteTweetTimeline(url: url, httpGetClient: httpGetClient,
                                      params: params, header: header)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
    
    func expect(_ sut: RemoteTweetTimeline,
                expectedResult: TweetTimeline.Result,
                when action: () -> Void = { _ = (() -> Void).self },
                model: FetchTweetTimelineModel = makeFetchTwitterTimeLine(),
                file: StaticString = #filePath,
                line: UInt = #line) {
        
        let exp = expectation(description: "waiting")
        sut.fetchTweetTimeLine(fetchTweetTimeLineModel: model) { receivedResult in
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
