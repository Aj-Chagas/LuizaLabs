//
//  BaseSnapshot.swift
//  UITests
//
//  Created by Anderson Chagas on 10/08/21.
//

import Quick
import Nimble
import Nimble_Snapshots
import UIKit
@testable import UI

class BaseSnapshot: QuickSpec {
    let iphoneSizes = ["iphone8": CGSize(width: 375, height: 667),
                       "iphone11pro": CGSize(width: 375, height: 812),
                       "iphoneSE": CGSize(width: 320, height: 568)]

    func iphone8Frame() -> CGRect {
        return CGRect(x: 0, y: 0, width: 375, height: 667)
    }
}
