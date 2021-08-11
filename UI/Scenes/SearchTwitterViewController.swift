//
//  SearchTwitterViewController.swift
//  UI
//
//  Created by Anderson Chagas on 10/08/21.
//

import UIKit
import Presentation

public final class SearchTwitterViewController: UIViewController, ControllerWithMainView, Storyboarded {
    typealias MainView = SearchTwitterView

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        hideErrorView()
    }

    func setupViews() {
        hideErrorView()
        setupSearchButton()
    }
    
    func hideErrorView() {
        mainView.errorIcon.alpha = 0
        mainView.errorMessageLabel.alpha = 0
    }

    func setupSearchButton() {
        mainView.searchButton.layer.cornerRadius = 4
    }
}

extension SearchTwitterViewController: LoadingView {
    public func display(viewModel: LoadingViewModel) {
        if viewModel.isLoading {
            view.isUserInteractionEnabled = false
            mainView.loadingIndicator?.startAnimating()
        } else {
            view.isUserInteractionEnabled = true
            mainView.loadingIndicator?.stopAnimating()
        }
        
    }
}

extension SearchTwitterViewController: SearchTwitterDelegate {

    public func showErrorMessage(_ errorMessage: String) {
        mainView.errorIcon.alpha = 1
        mainView.errorMessageLabel.alpha = 1
        mainView.errorMessageLabel.text = errorMessage
    }
    
    public func showErrorScreen() {
        // call showError
    }
    
    public func goToTimeline(_ tweetTimelineViewModel: [TweetViewModel], _ twitterProfileViewModel: TwitterProfileViewModel) {
        // call goToTimeLine
    }
    

}
