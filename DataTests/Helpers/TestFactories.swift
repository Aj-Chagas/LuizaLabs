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

func makeUrl() -> URL {
    URL(string: "http://any-url.com")!
}
