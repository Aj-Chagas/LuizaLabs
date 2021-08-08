//
//  TestFactories.swift
//  DataTests
//
//  Created by Anderson Chagas on 07/08/21.
//

import Foundation
import Domain

func makeFetchTwitterProfileModel() -> FetchTwitterProfileModel {
    FetchTwitterProfileModel(userName: "any_name")
}

func makeTwitterProfileModel() -> TwitterProfileModel {
    TwitterProfileModel(data: Profile(id: "any_id", name: "any_name", username: "any_userName"))
}

func makeInvalidFetchTwitterProfileModel() -> FetchTwitterProfileModel {
    FetchTwitterProfileModel(userName: "˜!@")
}

func makeHeader() -> [String: String] {
    ["any_name": "any_value"]
}

func makeUrl() -> URL {
    URL(string: "http://any-url.com/")!
}

func makeInvalidData() -> Data {
    Data("invalid_data".utf8)
}

func makeValidData() -> Data {
    Data("{\"name\": \"Anderson\"}".utf8)
}

func makeHttpResponse(statusCode: Int = 200) -> HTTPURLResponse {
    HTTPURLResponse(url: makeUrl(), statusCode: statusCode, httpVersion: nil, headerFields: nil)!
}

func makeError() -> NSError {
    NSError(domain: "any_error", code: 0)
}
