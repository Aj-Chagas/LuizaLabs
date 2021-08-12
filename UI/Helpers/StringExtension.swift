//
//  StringExtension.swift
//  UI
//
//  Created by Anderson Chagas on 12/08/21.
//

import Foundation

extension String {

    func hexToGlyph() -> String {
        guard let charAsInt = Int(self, radix: 16),
              let uScalar = UnicodeScalar(charAsInt) else { return String() }
        return String(uScalar)
    }

}


