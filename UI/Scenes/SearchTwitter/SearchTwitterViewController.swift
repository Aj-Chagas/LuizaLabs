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
    
    public var errorFactory: (() -> Void)?
    public var tweetTimelineFactory: ((UINavigationController, [TweetViewModel], TwitterProfileViewModel) -> Void)?
    public var searchTwitter: ((SearchTwitterRequest) -> Void)?

    deinit {
        NotificationCenter.default.removeObserver(self)
        unregisterForKeyboardNotifications()
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        hideErrorView()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Buscar tweets"
    }

    func setupViews() {
        hideErrorView()
        setupSearchButton()
        hideKeyboardOnTap()
        registerForKeyboardNotifications()
    }
    
    func hideErrorView() {
        mainView.errorIcon.alpha = 0
        mainView.errorMessageLabel.alpha = 0
    }

    func setupSearchButton() {
        mainView.searchButton.layer.cornerRadius = 4
        mainView.searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Actions
    
    @objc
    func searchButtonTapped() {
        let userName = mainView.textField.text?.replacingOccurrences(of: "@", with: "")
        searchTwitter?(SearchTwitterRequest(userName: userName ?? String()))
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
        errorFactory?()
    }
    
    public func goToTimeline(_ tweetTimelineViewModel: [TweetViewModel], _ twitterProfileViewModel: TwitterProfileViewModel) {
        guard let navController = navigationController else { return }
        mainView.textField.resignFirstResponder()
        tweetTimelineFactory?(navController, tweetTimelineViewModel, twitterProfileViewModel)
    }

}

extension SearchTwitterViewController: KeyboardSelector {
    var viewBottomConstraint: NSLayoutConstraint! {
        get {
            self.mainView.bottomConstraint
        }
        set {
            self.mainView.bottomConstraint = newValue
        }
    }

    func keyBoardWillShow(_ sender: Notification) {
        ajustViewToShowKeyboard(sender)
    }

    func keyBoardWillHide() {
        ajustViewToHideKeyboard(height: 16)
    }

}
