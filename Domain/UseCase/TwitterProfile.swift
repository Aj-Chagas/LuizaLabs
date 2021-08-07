//
//  FetchAccountByUserName.swift
//  Domain
//
//  Created by Anderson Chagas on 07/08/21.
//

import Foundation

public protocol TwitterProfile {
    typealias Result = Swift.Result<TwitterProfileModel, DomainError>
    func fetchTwitterProfile(fetchTwitterProfileModel: FetchTwitterProfileModel, completion: @escaping (Result) -> Void )
}

public struct FetchTwitterProfileModel {
    public let userName: String

    public init(userName: String) {
        self.userName = userName
    }
}
