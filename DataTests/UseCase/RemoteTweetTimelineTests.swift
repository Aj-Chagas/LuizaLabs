//
//  RemoteTweetTimelineTests.swift
//  DataTests
//
//  Created by Anderson Chagas on 08/08/21.
//

import XCTest
import Data

class RemoteTweetTimelineTests: XCTestCase {
    func test_fetchTwitterProfile_should_call_httpGetClient_with_correct_params() {
        let httpClient = HttpGetClientSpy()
        let model = makeFetchTwitterTimeLine()
        let url = makeUrl()
        let params = makeParams()
        let header = makeHeader()
        let sut = makeSut(url: url, httpGetClient: httpClient, params: params, header: header)
        
        // When
        sut.fetchTweetTimeLine(fetchTweetTimeLineModel: model) { _ in }
        
        // Then
        XCTAssertEqual(httpClient.urls, [url])
        XCTAssertEqual(httpClient.headers, header)
        XCTAssertEqual(httpClient.params as! [String: Int], params as! [String: Int])
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
}
