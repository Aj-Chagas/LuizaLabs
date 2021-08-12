//
//  ConclusionSnapshot.swift
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

class ConclusionSnapshot: BaseSnapshot {
    
    override func spec() {
        
        it("has valid snapshot") {
            let sut = ConclusionViewController.instantiate()
            sut.mainView.tweetLabel.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."
            sut.mainView.resultIcon.text = "1f603".hexToGlyph()
            expect(sut.mainView) == snapshot()
        }
        
    }
    
}
