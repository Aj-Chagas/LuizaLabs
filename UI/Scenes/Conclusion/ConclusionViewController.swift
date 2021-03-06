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
        setupViews()
        calculateAnalizeSentiment()
    }

    func setupViews() {
        mainView.tweetLabel.text = tweet
    }

    func calculateAnalizeSentiment() {
        guard let score = analyzeSentimentViewModel?.score,
              let calculateSentiment = calculateSentiment else { return }
        let (text, icon) = calculateSentiment(score)
        mainView.resultLabel.text = text
        mainView.resultIcon.text = icon.hexToGlyph()
    }
}
