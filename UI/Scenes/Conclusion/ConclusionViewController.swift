//
//  ConclusionViewController.swift
//  UI
//
//  Created by Anderson Chagas on 11/08/21.
//

import UIKit
import Presentation

public final class ConclusionViewController: UIViewController, ControllerWithMainView, Storyboarded {

    typealias MainView = ConclusionView

    public var tweet: String?
    public var analyzeSentimentViewModel: AnalyzeSentimentViewModel?
    public var calculateSentiment: ((Double) -> (text: String, icon: String))?

    public override func viewDidLoad() {
        mainView.tweetLabel.text = tweet
        let (text, icon) = calculateSentiment!(analyzeSentimentViewModel!.score)
        mainView.resultLabel.text = text
        mainView.resultIcon.text = icon.hexToGlyph()
    }

}
