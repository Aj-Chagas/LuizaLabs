//
//  URLSessionAdapterTests.swift
//  InfraTests
//
//  Created by Anderson Chagas on 07/08/21.
//

import XCTest
import Data
import Infra

class URLSessionAdapterTests: XCTestCase {

    func test_get_should_make_request_with_valid_url_and_method() {
        let sut = makeSut()
        let exp = expectation(description: "Waiting")
        let url = URL(string: "http://any-url.com")!
        var request: URLRequest?
        URLProtocolStubs.observerRequest(completion: { request = $0 })
        sut.get(to: url, with: makeValidData(), completion: { _ in exp.fulfill() })
        wait(for: [exp], timeout: 1)
        XCTAssertEqual(url, request?.url)
        XCTAssertEqual("GET", request?.httpMethod)
    }
    
    func test_get_should_complete_with_error_when_received_error() {
        expectResult(.failure(.serverError), when: (data: nil, response: nil, error: makeError()))
    }
    
    func test_get_should_complete_with_error_when_received_data_and_error() {
        expectResult(.failure(.serverError), when: (data: makeValidData(), response: nil, error: makeError()))
    }
    
    func test_get_should_complete_with_error_when_not_received_data_and_error() {
        expectResult(.failure(.serverError), when: (data: nil, response: nil, error: nil))
    }

    func test_get_should_complete_with_success_when_request_completes_with_data_and_status_code_200() {
        expectResult(.success(makeValidData()), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 200), error: nil))
        expectResult(.success(makeValidData()), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 299), error: nil))
        expectResult(.success(makeValidData()), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 202), error: nil))
        expectResult(.success(makeValidData()), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 203), error: nil))
        expectResult(.success(makeValidData()), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 204), error: nil))
    }
    
    func test_get_should_complete_with_success_when_request_completes_with_data_and_status_code_between_400_499() {
        expectResult(.failure(.badRequest), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 400), error: nil))
        expectResult(.failure(.badRequest), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 499), error: nil))
        expectResult(.failure(.badRequest), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 450), error: nil))
    }
    
    func test_get_should_complete_with_success_when_request_completes_with_data_and_status_code_between_500_599() {
        expectResult(.failure(.serverError), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 500), error: nil))
        expectResult(.failure(.serverError), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 599), error: nil))
        expectResult(.failure(.serverError), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 550), error: nil))
    }
    
    func test_get_should_complete_with_success_when_request_completes_with_data_status_code_non_between_200_to_599() {
        expectResult(.failure(.noConnectivity), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 600), error: nil))
        expectResult(.failure(.noConnectivity), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 100), error: nil))
        expectResult(.failure(.noConnectivity), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 800), error: nil))
    }
    

}

extension URLSessionAdapterTests {
    func makeSut() -> AlamofireAdapter {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [URLProtocolStubs.self]
        let session = URLSession(configuration: configuration)
        let sut = AlamofireAdapter(session: session)
        return sut
    }
    
    func expectResult(_ expectedResult: Result<Data?, HttpError>,
                      when stub: (data: Data?, response: HTTPURLResponse?, error: Error?),
                      file: StaticString = #filePath, line: UInt = #line) {
        let sut = makeSut()
        let exp = expectation(description: "Waiting")
        URLProtocolStubs.requestSimulate(data: stub.data, response: stub.response, error: stub.error)
    
        sut.get(to: makeUrl(), with: makeValidData()) { receivedResult in
            switch (expectedResult, receivedResult) {
            case (.failure(let expectedError), .failure(let receivedError)): XCTAssertEqual(expectedError, receivedError, file: file, line: line)
            case (.success(let expectedSuccess), .success(let receivedSuccess)): XCTAssertEqual(expectedSuccess, receivedSuccess, file: file, line: line)
            default: XCTFail("expected \(expectedResult) got \(receivedResult) instead")
            }
            
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }

}
