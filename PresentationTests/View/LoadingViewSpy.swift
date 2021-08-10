//
//  LoadingViewSpy.swift
//  PresentationTests
//
//  Created by Anderson Chagas on 10/08/21.
//

import Foundation
import Presentation

class LoadingViewSpy: LoadingView {

    var emit: ((LoadingViewModel) -> Void)?

    func observer(completion: @escaping (LoadingViewModel) -> Void) {
        self.emit = completion
    }

    func display(viewModel: LoadingViewModel) {
        emit?(viewModel)
    }

}
