//
//  SearchTwitterSpy.swift
//  PresentationTests
//
//  Created by Anderson Chagas on 09/08/21.
//

import Foundation
import Presentation

class SearchTwitterSpy: SearchTwitterDelegate {
    var errorMessage: String?
    var errorScreen: Bool = false
    
    func showErrorMessage(_ errorMessage: String) {
        self.errorMessage = errorMessage
    }
    
    func showErrorScreen() {
        errorScreen = true
    }
}
