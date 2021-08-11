//
//  TweetTimelineViewController.swift
//  UI
//
//  Created by Anderson Chagas on 11/08/21.
//

import UIKit
import Presentation

public final class TweetTimelineViewController: UIViewController, ControllerWithMainView, Storyboarded {

    typealias MainView = TweetTimelineView
    
    public override func viewDidLoad() {
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Timeline"
    }
    
    
}
