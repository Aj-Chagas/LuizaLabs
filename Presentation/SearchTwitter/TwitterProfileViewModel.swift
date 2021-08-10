//
//  TwitterProfileViewModel.swift
//  Presentation
//
//  Created by Anderson Chagas on 10/08/21.
//

import Foundation
import Domain

public struct TwitterProfileViewModel: Model {

    public var twitterProfile: TwitterProfileModel

    public init(twitterProfile: TwitterProfileModel) {
        self.twitterProfile = twitterProfile
    }

    public var id: String {
        twitterProfile.data.id
    }

    public var name: String {
        twitterProfile.data.name
    }

    public var username: String {
        twitterProfile.data.username
    }

}
