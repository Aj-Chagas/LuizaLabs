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
        let httpGetClient = HttpGetClientSpy()
        let sut = makeSut(httpGetClient: httpGetClient)

        expect(sut, expectedResult: .failure(.unexpected), when: {
            httpGetClient.completionWithError()
        })

    }

    func test_fetchTwitterProfile_should_complete_with_success_if_client_with_valid_data() {
        let httpGetClient = HttpGetClientSpy()
        let sut = makeSut(httpGetClient: httpGetClient)
        let model = makeTwitterProfileModel()
        
        expect(sut, expectedResult: .success(model), when: {
            httpGetClient.completionWithSuccess(model.toData())
        })
    }

    func test_fetchTwitterProfile_should_complete_with_error_if_client_with_invalid_data() {
        let httpGetClient = HttpGetClientSpy()
        let sut = makeSut(httpGetClient: httpGetClient)
        
        expect(sut, expectedResult: .failure(.unexpected), when: {
            httpGetClient.completionWithSuccess(makeInvalidData())
        })
    }

}

extension RemoteTwitterProfileTests {
    func makeSut(url: URL = makeUrl(),
                 httpGetClient: HttpGetClient = HttpGetClientSpy(),
                 file: StaticString = #filePath,
                 line: UInt = #line) -> RemoteTwitterProfile {
        let sut = RemoteTwitterProfile(url: url, httpGetClient: httpGetClient)
        addTeardownBlock { [weak sut] in
            XCTAssertNil(sut, file: file, line: line)
        }
        return sut
    }
    
    func expect(_ sut: RemoteTwitterProfile,
                expectedResult: TwitterProfile.Result,
                when action: () -> Void,
                file: StaticString = #filePath,
                line: UInt = #line) {
        
        let exp = expectation(description: "waiting")
        sut.fetchTwitterProfile(fetchTwitterProfileModel: makeFetchTwitterProfileModel()) { receivedResult in
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
    

class HttpGetClientSpy: HttpGetClient {
    
    var urls = [URL]()
    var data: Data?
    var completion: ((Result<Data?, HttpError>) -> Void)?

    func get(to url: URL, with data: Data?, completion: @escaping (Result<Data?, HttpError>) -> Void) {
        self.urls.append(url)
        self.data = data
        self.completion = completion
    }
    
    func completionWithError(_ httpError: HttpError = .noConnectivity) {
        completion?(.failure(httpError))
    }
    
    func completionWithSuccess(_ data: Data?) {
        completion?(.success(data))
    }

}
