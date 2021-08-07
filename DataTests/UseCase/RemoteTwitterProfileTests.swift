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
        let sut = makeSut(url: url, httpGetClient: httpClient)
        let model = makeFetchTwitterProfileModel()
        
        // When
        sut.fetchTwitterProfile(fetchTwitterProfileModel: model) { _ in }
        
        // Then
        XCTAssertEqual(httpClient.urls, [url])
        XCTAssertEqual(httpClient.data, model.toData())
    }

    func test_fetchTwitterProfile_should_complete_with_error_if_client_completes_with_error() {
        
    }

}

extension RemoteTwitterProfileTests {
    func makeSut(url: URL = makeUrl(),
                 httpGetClient: HttpGetClient = HttpGetClientSpy(),
                 file: StaticString = #filePath,
                 line: UInt = #line) -> RemoteTwitterProfile {
        let sut = RemoteTwitterProfile(url: url, httpGetClient: httpGetClient)
        addTeardownBlock { [weak sut] in
            XCTAssertNil(sut)
        }
        return sut
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
