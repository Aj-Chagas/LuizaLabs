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
    func showErrorScreen()
}

public final class SearchTwitterPresentation {
    
    private let twitterProfile: TwitterProfile
    private let delegate: SearchTwitterDelegate
    
    public init(twitterProfile: TwitterProfile, delegate: SearchTwitterDelegate) {
        self.twitterProfile = twitterProfile
        self.delegate = delegate
    }

    public func searchTwitter(searchTwitterRequest model: SearchTwitterRequest) {
        if let message = validate(model: model) {
            delegate.showErrorMessage(message)
        } else {
            twitterProfile.fetchTwitterProfile(fetchTwitterProfileModel: model.toFetchTweetProfileModel()) { result in
                switch result {
                case .success: break
                case .failure(let error):
                    switch error {
                    case .invalidUserName:
                        self.delegate.showErrorMessage("nome de usuário inválido")
                    case .userNameNotFound:
                        self.delegate.showErrorMessage("nome de usuário não encontrado")
                    default:
                        self.delegate.showErrorScreen()
                    }
                }
            }
        }
    }
    
    private func validate(model: SearchTwitterRequest) -> String? {
        if model.userName.isEmpty {
            return "o campo nome do usuário é obrigatório"
        }
        return nil
    }

}
