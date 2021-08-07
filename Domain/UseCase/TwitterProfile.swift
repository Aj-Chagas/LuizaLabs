//
//  FetchAccountByUserName.swift
//  Domain
//
//  Created by Anderson Chagas on 07/08/21.
//

import Foundation

public protocol TwitterProfile {
    typealias Result = Swift.Result<TwitterProfileModel, Error>
}

public struct TwitterProfileModel {
    public let data: Profile
    
    public init(data: Profile) {
        self.data = data
    }
}

public struct Profile {
    public let id: String
    public let name: String
    public let userName: String
    
    public init(id: String, name: String, userName: String) {
        self.id = id
        self.name = name
        self.userName = userName
    }
}
