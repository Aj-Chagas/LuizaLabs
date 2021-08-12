//
//  ConclusionFactoryTests.swift
//  MainTests
//
//  Created by Anderson Chagas on 11/08/21.
//

import XCTest
import Main

class ConclusionFactoryTests: XCTestCase {

    func test_makeConclusionFactory_compose_with_correct_injections() {
        let tweet = "any_tweet"
        let analyzeSentimentViewModel = makeAnalyzeSentimentViewModel()
        let sut = makeConclusionFactory(tweet: tweet, analyzeSentimentViewModel: analyzeSentimentViewModel)
        checkMemoryLeak(for: sut)
    }

}
