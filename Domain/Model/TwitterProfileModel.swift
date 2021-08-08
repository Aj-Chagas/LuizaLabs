//
//  TwitterProfileModel.swift
//  Domain
//
//  Created by Anderson Chagas on 07/08/21.
//

import Foundation

public struct TwitterProfileModel: Model {
    public let data: Profile
    
    public init(data: Profile) {
        self.data = data
    }
}

public struct Profile: Model {
    public let id: String
    public let name: String
    public let username: String
    
    public init(id: String, name: String, username: String) {
        self.id = id
        self.name = name
        self.username = username
    }
}
