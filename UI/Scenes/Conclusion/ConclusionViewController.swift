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
    public var calculateSentiment: (() -> (text: String, icon: String))?

    public override func viewDidLoad() {
        mainView.tweetLabel.text = tweet
        let (text, icon) = calculateSentiment!()
        mainView.resultLabel.text = text
        mainView.resultIcon.text = icon
        
    }

}
