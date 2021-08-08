//
//  XCTestCaseExtensions.swift
//  DataTests
//
//  Created by Anderson Chagas on 08/08/21.
//

import XCTest

extension XCTestCase {
    func checkMemoryLeak(for instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, file: file, line: line)
        }
    }
}
