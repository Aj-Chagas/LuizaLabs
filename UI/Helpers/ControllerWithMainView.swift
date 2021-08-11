//
//  ControllerWithMainView.swift
//  UI
//
//  Created by Anderson Chagas on 10/08/21.
//

import UIKit

protocol ControllerWithMainView: AnyObject {
    associatedtype MainView
}

extension ControllerWithMainView where Self: UIViewController {
    var mainView: MainView {
        guard let mainView = self.view as? MainView else {
            fatalError("setup mainView")
        }
        return mainView
    }
}

