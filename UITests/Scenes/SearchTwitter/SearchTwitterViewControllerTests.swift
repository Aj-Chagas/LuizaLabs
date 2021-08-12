//
//  SearchTwitterViewControllerTests.swift
//  UITests
//
//  Created by Anderson Chagas on 10/08/21.
//

import XCTest
import Presentation
@testable import UI

class SearchTwitterViewControllerTests: XCTestCase {

    func test_SearchTwitterViewController_implements_loading_view_protocol() {
        let sut = makeSut()
        XCTAssertNotNil(sut as LoadingView)
    }
    
    func test_SearchTwitterViewController_implements_searchTwitterDelegate_protocol() {
        let sut = makeSut()
        XCTAssertNotNil(sut as SearchTwitterDelegate)
    }

    func test_display_should_hidden_loading_indicator() {
        let sut = makeSut()
        
        sut.display(viewModel: LoadingViewModel(isLoading: false))
        
        XCTAssertEqual(sut.mainView.loadingIndicator?.isAnimating, false)
    }

    func test_display_should_show_loading_indicator() {
        let sut = makeSut()
        
        sut.display(viewModel: LoadingViewModel(isLoading: true))
        
        XCTAssertEqual(sut.mainView.loadingIndicator?.isAnimating, true)
    }

    func test_searchButtonTapped_should_calls_searchTwitter_on_tap() {
        var viewModel: SearchTwitterRequest?
        let sut = makeSut()
        sut.searchTwitter = { viewModel = $0 }
        
        sut.mainView.searchButton?.simulateTap()
        
        XCTAssertEqual(viewModel, SearchTwitterRequest(userName: ""))
    }
}

extension SearchTwitterViewControllerTests {
    func makeSut() -> SearchTwitterViewController {
        let sut = SearchTwitterViewController.instantiate()
        checkMemoryLeak(for: sut)
        sut.loadViewIfNeeded()
        return sut
    }
}

extension UIControl {

    func simulate(event: UIControl.Event) {
        allTargets.forEach { target in
            self.actions(forTarget: target, forControlEvent: event)?.forEach { action in
                (target as NSObject).perform(Selector(action))
            }
        }
    }

    func simulateTap() {
        simulate(event: .touchUpInside)
    }
}
