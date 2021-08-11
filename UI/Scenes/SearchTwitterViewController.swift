//
//  SearchTwitterViewController.swift
//  UI
//
//  Created by Anderson Chagas on 10/08/21.
//

import UIKit

class SearchTwitterViewController: UIViewController {
    
    lazy var searchTwitterView: SearchTwitterView = {
        SearchTwitterView(frame: .zero)
    }()
    
    override func loadView() {
        self.view = searchTwitterView
    }
}
