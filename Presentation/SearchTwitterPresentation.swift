//
//  Presentation.swift
//  Presentation
//
//  Created by Anderson Chagas on 09/08/21.
//

import Foundation
import Domain

public protocol SearchTwitterDelegate: AnyObject {
    func showErrorMessage(_ errorMessage: String)
}

public final class SearchTwitterPresentation {
    
    private let twitterProfile: TwitterProfile
    private let delegate: SearchTwitterDelegate
    
    public init(twitterProfile: TwitterProfile, delegate: SearchTwitterDelegate) {
        self.twitterProfile = twitterProfile
        self.delegate = delegate
    }

    public func seachTwitter(searchTwitterRequest model: SearchTwitterRequest) {
        if let message = validate(model: model) {
            delegate.showErrorMessage(message)
        } else {
            twitterProfile.fetchTwitterProfile(fetchTwitterProfileModel: model.toFetchTweetProfileModel()) { _ in }
        }
    }
    
    private func validate(model: SearchTwitterRequest) -> String? {
        if model.userName.isEmpty {
            return "o campo nome do usuário é obrigatório"
        }
        return nil
    }

}
