//
//  SearchTwitterFactoryTests.swift
//  MainTests
//
//  Created by Anderson Chagas on 12/08/21.
//

import XCTest
@testable import Main

class SearchTwitterFactoryTests: XCTestCase {
    func test_makeSearchTwitterFactory_should_create_instance_with_correct_injections_and_no_memoryleak() {
        let router = makeSearchTwitterRouter(nav: UINavigationController())
        let sut = makeSearchTwitterFactory(router: router)
        
        checkMemoryLeak(for: sut)
        XCTAssertNotNil(sut.searchTwitter)
        XCTAssertNotNil(sut.errorFactory)
        XCTAssertNotNil(sut.tweetTimelineFactory)
    }
}

