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
    public let userName: String
    
    public init(id: String, name: String, userName: String) {
        self.id = id
        self.name = name
        self.userName = userName
    }
}
