//
//  TweetTimelineFactoryTests.swift
//  MainTests
//
//  Created by Anderson Chagas on 12/08/21.
//

import XCTest
@testable import Main

class TweetTimelineFactoryTests: XCTestCase {
    func test_makeTweetTimeViewController_should_create_instance_with_correct_injections_and_no_memoryleak() {
        let router = makeTweetTimelineRouter(nav: UINavigationController())
        let tweetViewModel = makeTweetViewModel()
        let twitterViewModel = makeTwitterProfileViewModel()
        let sut = makeTweetTimeViewController(router: router,
                                              twitterViewModel: twitterViewModel,
                                              tweetViewModel:  tweetViewModel)
        
        checkMemoryLeak(for: sut)
        
        XCTAssertNotNil(sut.analyzeSentimet)
        XCTAssertNotNil(sut.goToError)
        XCTAssertNotNil(sut.goToConclusion)
        XCTAssertNotNil(sut.tweetViewModel)
        XCTAssertNotNil(sut.twitterViewModel)
    }
}
