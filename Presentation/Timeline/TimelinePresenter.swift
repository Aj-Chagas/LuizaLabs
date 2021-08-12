//
//  TimelinePresenter.swift
//  Presentation
//
//  Created by Anderson Chagas on 10/08/21.
//

import Foundation
import Domain

public protocol TimelineDelegate: AnyObject {
    func handlerError()
    func handlerSuccess(viewmodel: AnalyzeSentimentViewModel)
}

public final class TimelinePresenter {
    private let analyzeSentiment: AnalyzeSentiment
    private let loadingView: LoadingView
    private let delegate: TimelineDelegate
    
    public init(analyzeSentiment: AnalyzeSentiment,
                loadingView: LoadingView,
                delegate: TimelineDelegate) {
        self.analyzeSentiment = analyzeSentiment
        self.loadingView = loadingView
        self.delegate = delegate
    }
    
    public func analyzeSentiment(with model: TimeLineRequest) {
        loadingView.display(viewModel: LoadingViewModel(isLoading: true))
        analyzeSentiment.fetchAnalyzeSentiment(fetchTweetTimeLineModel: model.toFetchAnalyzeSentimentModel()) { [weak self] result in
            guard let self = self else { return }
            self.loadingView.display(viewModel: LoadingViewModel(isLoading: false))
            switch result {
            case .success(let model): self.delegate.handlerSuccess(viewmodel: AnalyzeSentimentViewModel(analyzeSentiment: model))
            case .failure: self.delegate.handlerError()
            }
        }
    }
}
