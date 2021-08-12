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
            return ("esse é um tweet feliz", hexToGlyph("1f603"))
        } else if score >= -0.25 && score <= 0.25 {
            return ("esse é um tweet neutro", hexToGlyph("1f610"))
        } else {
            return ("esse é um tweet triste", hexToGlyph("1f641"))
        }
    }
    
    private func hexToGlyph(_ hextString: String) -> String {
        guard let charAsInt = Int(hextString, radix: 16),
              let uScalar = UnicodeScalar(charAsInt) else { return String() }
        return String(uScalar)
    }
    
}

