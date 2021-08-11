//
//  SearchTwitterViewController.swift
//  UI
//
//  Created by Anderson Chagas on 10/08/21.
//

import UIKit

public final class SearchTwitterViewController: UIViewController, ControllerWithMainView, Storyboarded {
    typealias MainView = SearchTwitterView
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
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
