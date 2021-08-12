//
//  ErrorGenericViewController.swift
//  UI
//
//  Created by Anderson Chagas on 11/08/21.
//

import UIKit

public class ErrorGenericViewController: UIViewController, Storyboarded, ControllerWithMainView {
    
    typealias MainView = ErrorGenericView
    
    public override func viewDidLoad() {
        mainView.backButton.layer.cornerRadius = 4
        mainView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    @objc
    func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
}
