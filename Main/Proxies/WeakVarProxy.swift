//
//  WeakVarProxy.swift
//  Main
//
//  Created by Anderson Chagas on 12/08/21.
//

import Foundation
import Presentation

final class WeakVarProxy<T: AnyObject> {
    private weak var instance: T?

    init(_ instance: T) {
        self.instance = instance
    }
}

extension WeakVarProxy: LoadingView where T: LoadingView {
    func display(viewModel: LoadingViewModel) {
        instance?.display(viewModel: viewModel)
    }
}

extension WeakVarProxy: SearchTwitterDelegate where T: SearchTwitterDelegate {
    
    func showErrorMessage(_ errorMessage: String) {
        instance?.showErrorMessage(errorMessage)
    }
    
    func showErrorScreen() {
        instance?.showErrorScreen()
    }
    
    func goToTimeline(_ tweetTimelineViewModel: [TweetViewModel], _ twitterProfileViewModel: TwitterProfileViewModel) {
        instance?.goToTimeline(tweetTimelineViewModel, twitterProfileViewModel)
    }
}

extension WeakVarProxy: TimelineDelegate where T: TimelineDelegate {

    func handlerError() {
        instance?.handlerError()
    }
    
    func handlerSuccess(viewmodel: AnalyzeSentimentViewModel) {
        instance?.handlerSuccess(viewmodel: viewmodel)
    }

}
