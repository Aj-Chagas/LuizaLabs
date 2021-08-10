//
//  Presentation.swift
//  Presentation
//
//  Created by Anderson Chagas on 09/08/21.
//

import Foundation
import Domain

public final class SearchTwitterPresentation {
    
    private let twitterProfile: TwitterProfile
    
    public init(twitterProfile: TwitterProfile) {
        self.twitterProfile = twitterProfile
    }

    public func seachTwitter(searchTwitterRequest model: SearchTwitterRequest) {
        twitterProfile.fetchTwitterProfile(fetchTwitterProfileModel: model.toFetchTweetProfileModel()) { _ in }
    }

}
