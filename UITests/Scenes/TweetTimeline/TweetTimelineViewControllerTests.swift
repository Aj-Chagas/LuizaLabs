//
//  TweetTimelineViewControllerTests.swift
//  UITests
//
//  Created by Anderson Chagas on 12/08/21.
//

import XCTest
import Presentation
@testable import UI

class TweetTimelineViewControllerTests: XCTestCase {
    func test_TweetTimelineViewController_implements_loading_view_protocol() {
        let sut = makeSut()
        XCTAssertNotNil(sut as LoadingView)
    }
    
    func test_TweetTimelineViewController_implements_TimelineDelegate_protocol() {
        let sut = makeSut()
        XCTAssertNotNil(sut as TimelineDelegate)
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

    func test_cellForRowAt_should_return_TweetTimelineTableViewCell() {
        let sut = makeSut()
        let tableView = sut.mainView.tableView
        sut.tweetViewModel = makeTweetViewModel()
        let cell = tableView!.dataSource?.tableView(tableView!, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertNotNil(cell as! TweetTimelineTableViewCell)
    }

    func test_cellForRowAt_should_return_UITableViewCell() {
        let sut = makeSut()
        let tableView = sut.mainView.tableView
        let cell = tableView!.dataSource?.tableView(tableView!, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertNotNil(cell!)
    }

    func test_numberOfRowsInSection_should_return_UITableViewCell() {
        let sut = makeSut()
        let tableView = sut.mainView.tableView
        let tweetViewModel = makeTweetViewModel()
        sut.tweetViewModel = tweetViewModel
        let numberOfRowsInSection = tableView!.dataSource?.tableView(tableView!, numberOfRowsInSection: 1)
        XCTAssertEqual(numberOfRowsInSection, tweetViewModel.count)
    }

    func test_didSelectRowAt_should_calls_analyzeSentimet() {
        let sut = makeSut()
        let tableView = sut.mainView.tableView
        let tweetViewModel = makeTweetViewModel()
        sut.tweetViewModel = tweetViewModel
        var timeLineRequest: TimeLineRequest?
        sut.analyzeSentimet = { timeLineRequest = $0 }
        
        _ = tableView!.delegate?.tableView?(tableView!, didSelectRowAt: IndexPath(row: 0, section: 0))

        XCTAssertEqual(timeLineRequest, makeTimelineRequest())
    }
}

extension TweetTimelineViewControllerTests {
    func makeSut() -> TweetTimelineViewController {
        TweetTimelineViewController.instantiate()
    }
}
