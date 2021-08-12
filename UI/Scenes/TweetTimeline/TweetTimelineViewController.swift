//
//  TweetTimelineViewController.swift
//  UI
//
//  Created by Anderson Chagas on 11/08/21.
//

import UIKit
import Presentation

public final class TweetTimelineViewController: UIViewController, ControllerWithMainView, Storyboarded, LoadingView {

    typealias MainView = TweetTimelineView

    public var twitterViewModel: TwitterProfileViewModel?
    public var tweetViewModel: [TweetViewModel]?
    public var analyzeSentimet: ((TimeLineRequest) -> Void)?
    public var goToError: (() -> Void)?
    public var goToConclusion: ((_ tweet: String, _ sentimentViewModel: AnalyzeSentimentViewModel) -> Void)?

    var tweet: String?

    public override func viewDidLoad() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Timeline"
    }
    
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

extension TweetTimelineViewController: TimelineDelegate {

    public func handlerError() {
        goToError?()
    }

    public func handlerSuccess(viewmodel: AnalyzeSentimentViewModel) {
        goToConclusion?(tweet ?? String(), viewmodel)
    }

}


extension TweetTimelineViewController: UITableViewDelegate, UITableViewDataSource {

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tweetViewModel?.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = mainView.tableView.dequeueReusableCell(withIdentifier: TweetTimelineTableViewCell.kIdentifier) as? TweetTimelineTableViewCell,
              let model = tweetViewModel else {
            return UITableViewCell()
        }
        cell.setup(model[indexPath.row])
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let safetweet = tweetViewModel?[indexPath.row].text else { return }
        self.tweet = safetweet
        analyzeSentimet?(TimeLineRequest(tweet: safetweet))
    }
    
}
