//
//  ConclusionPresenterTests.swift
//  PresentationTests
//
//  Created by Anderson Chagas on 12/08/21.
//

import XCTest
import Presentation
import Domain

class ConclusionPresenterTests: XCTestCase {
    func test_calculateSentiment_should_return_neutral_when_score_is_between_negative_0_25_and_positive_0_25_range() {
        let sut = makeSut()
        
        let exptectedText = "esse é um tweet neutro"
        let expectedIcon = "1f610"
        
        XCTContext.runActivity(named: "expected result neutral when score is 0.0") { _ in
            let (text, icon) = sut.calculateSentiment(score: 0.0)
            
            XCTAssertEqual(text, exptectedText)
            XCTAssertEqual(icon, expectedIcon)
        }
        
        XCTContext.runActivity(named: "expected result neutral when score is -0.26") { _ in
            let (text, icon) = sut.calculateSentiment(score: -0.24)
            
            XCTAssertEqual(text, exptectedText)
            XCTAssertEqual(icon, expectedIcon)
        }
        
        XCTContext.runActivity(named: "expected result neutral when score is 0.24") { _ in
            let (text, icon) = sut.calculateSentiment(score: 0.24)
            
            XCTAssertEqual(text, exptectedText)
            XCTAssertEqual(icon, expectedIcon)
        }
    }

    func test_calculateSentiment_should_return_happy_when_score_is_between_positive_0_25_and_positive_1_0_range() {
        let sut = makeSut()
        
        let exptectedText = "esse é um tweet feliz"
        let expectedIcon = "1f603"
        
        XCTContext.runActivity(named: "expected result happy when score is 0.26") { _ in
            let (text, icon) = sut.calculateSentiment(score: 0.26)
            
            XCTAssertEqual(text, exptectedText)
            XCTAssertEqual(icon, expectedIcon)
        }
        
        XCTContext.runActivity(named: "expected result happy when score is 0.99") { _ in
            let (text, icon) = sut.calculateSentiment(score: 0.99)
            
            XCTAssertEqual(text, exptectedText)
            XCTAssertEqual(icon, expectedIcon)
        }
        
        XCTContext.runActivity(named: "expected result happy when score is 0.50") { _ in
            let (text, icon) = sut.calculateSentiment(score: 0.50)
            
            XCTAssertEqual(text, exptectedText)
            XCTAssertEqual(icon, expectedIcon)
        }
    }

    func test_calculateSentiment_should_return_sad_when_score_is_not_within_happy_or_neutal_range() {
        let sut = makeSut()
        
        let exptectedText = "esse é um tweet triste"
        let expectedIcon = "1f641"
        
        XCTContext.runActivity(named: "expected result happy when score is -1.0") { _ in
            let (text, icon) = sut.calculateSentiment(score: -0.99)
            
            XCTAssertEqual(text, exptectedText)
            XCTAssertEqual(icon, expectedIcon)
        }
        
        XCTContext.runActivity(named: "expected result happy when score is -0.99") { _ in
            let (text, icon) = sut.calculateSentiment(score: -0.99)
            
            XCTAssertEqual(text, exptectedText)
            XCTAssertEqual(icon, expectedIcon)
        }
        
        XCTContext.runActivity(named: "expected result happy when score is -0.28") { _ in
            let (text, icon) = sut.calculateSentiment(score: -0.28)
            
            XCTAssertEqual(text, exptectedText)
            XCTAssertEqual(icon, expectedIcon)
        }
        
        XCTContext.runActivity(named: "expected result happy when score is -0.26") { _ in
            let (text, icon) = sut.calculateSentiment(score: -0.50)
            
            XCTAssertEqual(text, exptectedText)
            XCTAssertEqual(icon, expectedIcon)
        }
    }
}

extension ConclusionPresenterTests {
    func makeSut() -> ConclusionPresenter {
        ConclusionPresenter()
    }
}

