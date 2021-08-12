//
//  TimelineDelegateSpy.swift
//  PresentationTests
//
//  Created by Anderson Chagas on 12/08/21.
//

import Foundation
import Presentation

class TimelineDelegateSpy: TimelineDelegate {

    var error: Bool = false
    var viewmodel: AnalyzeSentimentViewModel?

    func handlerError() {
        self.error = true
    }
    
    func handlerSuccess(viewmodel: AnalyzeSentimentViewModel) {
        self.viewmodel = viewmodel
    }

}
