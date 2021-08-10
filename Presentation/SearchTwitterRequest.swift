//
//  SearchTwitterRequest.swift
//  Presentation
//
//  Created by Anderson Chagas on 09/08/21.
//

import Foundation
import Domain

public struct SearchTwitterRequest: Model {

    public var userName: String

    public init(userName: String) {
        self.userName = userName
    }

    func toFetchTweetProfileModel() -> FetchTwitterProfileModel {
        FetchTwitterProfileModel(userName: userName)
    }
}
