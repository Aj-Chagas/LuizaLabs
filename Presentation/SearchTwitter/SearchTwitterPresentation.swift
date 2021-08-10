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
    func goToTimeline(_ tweetTimelineViewModel: [TweetViewModel], _ twitterProfileViewModel: TwitterProfileViewModel)
}

public final class SearchTwitterPresentation {
    
    private let twitterProfile: TwitterProfile
    private let tweetTimeline: TweetTimeline
    private let delegate: SearchTwitterDelegate
    private let loadingView: LoadingView
    
    public init(twitterProfile: TwitterProfile, tweetTimeline: TweetTimeline, delegate: SearchTwitterDelegate, loadingView: LoadingView) {
        self.twitterProfile = twitterProfile
        self.tweetTimeline = tweetTimeline
        self.delegate = delegate
        self.loadingView = loadingView
    }

    public func searchTwitter(searchTwitterRequest model: SearchTwitterRequest) {
        if let message = validate(model: model) {
            delegate.showErrorMessage(message)
        } else {
            loadingView.display(viewModel: LoadingViewModel(isLoading: true))
            twitterProfile.fetchTwitterProfile(fetchTwitterProfileModel: model.toFetchTweetProfileModel()) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let twitterProfileModel):
                    let twitterProfileViewModel = TwitterProfileViewModel(twitterProfile: twitterProfileModel)
                     self.fetchTweetTimeline(with: twitterProfileViewModel)
                case .failure(let error):
                    self.loadingView.display(viewModel: LoadingViewModel(isLoading: false))
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

    public func fetchTweetTimeline(with viewModel: TwitterProfileViewModel) {
        tweetTimeline.fetchTweetTimeLine(fetchTweetTimeLineModel: FetchTweetTimelineModel(id: viewModel.id)) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let tweetTimelineModel):
                let tweetViewModel = tweetTimelineModel.data.map { TweetViewModel(tweet: $0) }
                self.delegate.goToTimeline(tweetViewModel, viewModel)
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
