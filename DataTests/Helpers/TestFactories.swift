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
    TwitterProfileModel(data: Profile(id: "any_id", name: "any_name", userName: "any_userName"))
}

func makeUrl() -> URL {
    URL(string: "http://any-url.com")!
}

func makeInvalidData() -> Data {
    Data("invalid_data".utf8)
}

func makeValidData() -> Data {
    Data("{\"name\": \"Anderson\"}".utf8)
}
