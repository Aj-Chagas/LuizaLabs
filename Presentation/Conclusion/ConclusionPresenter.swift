//
//  ConclusionPresenter.swift
//  Presentation
//
//  Created by Anderson Chagas on 11/08/21.
//

import Foundation

public final class ConclusionPresenter {
    
    private let analyzeSentimentViewModel: AnalyzeSentimentViewModel
    
    public init(analyzeSentimentViewModel: AnalyzeSentimentViewModel) {
        self.analyzeSentimentViewModel = analyzeSentimentViewModel
    }
    
    public func calculateSentiment() -> (String, String) {
        let score = analyzeSentimentViewModel.score
        
        if score >= 0.25 && score <= 1.0 {
            return ("feliz", hexToGlyph("e008"))
        } else if score >= -0.25 && score <= 0.25 {
            return ("neutro", hexToGlyph("e008"))
        } else {
            return ("triste", hexToGlyph("e008"))
        }
    }
    
    private func hexToGlyph(_ hextString: String) -> String {
        guard let charAsInt = Int(hextString, radix: 16),
              let uScalar = UnicodeScalar(charAsInt) else { return String() }
        return String(uScalar)
    }
    
}

