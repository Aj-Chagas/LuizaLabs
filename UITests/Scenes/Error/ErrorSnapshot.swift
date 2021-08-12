//
//  ErrorSnapshot.swift
//  UITests
//
//  Created by Anderson Chagas on 12/08/21.
//

import Quick
import Nimble
import Nimble_Snapshots
import UIKit
@testable import UI

class ErrorSnapshot: BaseSnapshot {
    
    override func spec() {
        
        it("has valid snapshot") {
            let sut = ErrorGenericViewController.instantiate()
            expect(sut.mainView) == snapshot(sizes: self.iphoneSizes)
        }
        
    }
    
}
