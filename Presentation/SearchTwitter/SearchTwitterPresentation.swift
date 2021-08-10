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
    func goToTimeline(_ tweetTimelineModel: TweetTimelineModel)
}

public final class SearchTwitterPresentation {
    
    private let twitterProfile: TwitterProfile
    private let tweetTimeline: TweetTimeline
    private let delegate: SearchTwitterDelegate
    
    public init(twitterProfile: TwitterProfile, tweetTimeline: TweetTimeline, delegate: SearchTwitterDelegate) {
        self.twitterProfile = twitterProfile
        self.tweetTimeline = tweetTimeline
        self.delegate = delegate
    }

    public func searchTwitter(searchTwitterRequest model: SearchTwitterRequest) {
        if let message = validate(model: model) {
            delegate.showErrorMessage(message)
        } else {
            twitterProfile.fetchTwitterProfile(fetchTwitterProfileModel: model.toFetchTweetProfileModel()) { result in
                switch result {
                case .success(let twitterProfileModel):
                    self.fetchTweetTimeline(with: FetchTweetTimelineModel(id: twitterProfileModel.data.id))
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

    public func fetchTweetTimeline(with model: FetchTweetTimelineModel) {
        tweetTimeline.fetchTweetTimeLine(fetchTweetTimeLineModel: model) { result in
            switch result {
            case .success(let tweetTimelineModel): self.delegate.goToTimeline(tweetTimelineModel)
            case .failure: self.delegate.showErrorScreen()
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
