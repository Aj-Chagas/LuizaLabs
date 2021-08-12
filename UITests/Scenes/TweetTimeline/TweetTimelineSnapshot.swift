//
//  TweetTimelineSnapshot.swift
//  UITests
//
//  Created by Anderson Chagas on 12/08/21.
//

import Quick
import Nimble
import Nimble_Snapshots
import UIKit
@testable import UI

// Default iphone to run snapshot test is iphone 8

class TweetTimelineSnapshot: BaseSnapshot {
    
    override func spec() {
        
        it("has valid snapshot") {
            let sut = TweetTimelineViewController.instantiate()
            sut.loadViewIfNeeded()
            expect(sut.mainView) == snapshot(sizes: self.iphoneSizes)
        }
        
    }
    
}
