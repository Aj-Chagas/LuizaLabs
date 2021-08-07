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
        let httpClient = HttpGetClientSpy()
        let url = makeUrl()
        let model = makeFetchTwitterProfileModel()
        let sut = RemoteTwitterProfile(url: url, httpGetClient: httpClient)
        
        // When
        sut.fetchTwitterProfile(fetchTwitterProfileModel: model) { _ in }
        
        // Then
        XCTAssertEqual(httpClient.urls, [url])
        XCTAssertEqual(httpClient.data, model.toData())
    }

}

class HttpGetClientSpy: HttpGetClient {
    
    var urls = [URL]()
    var data: Data?
    var completion: ((Result<Data?, HttpError>) -> Void)?

    func get(to url: URL, with data: Data?, completion: @escaping (Result<Data?, HttpError>) -> Void) {
        self.urls.append(url)
        self.data = data
        self.completion = completion
    }

}
