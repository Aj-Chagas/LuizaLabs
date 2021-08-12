//
//  ConclusionPresenter.swift
//  Presentation
//
//  Created by Anderson Chagas on 11/08/21.
//

import Foundation

public final class ConclusionPresenter {
    
    public init() { }
    
    public func calculateSentiment(score: Double) -> (String, String) {
        if score > 0.25 && score < 1.0 {
            return ("esse é um tweet feliz", "1f603")
        } else if score > -0.25 && score < 0.25 {
            return ("esse é um tweet neutro", "1f610")
        }
        return ("esse é um tweet triste", "1f641")
        
    }
    
}

