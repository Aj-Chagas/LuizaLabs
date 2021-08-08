//
//  AnalyzeSentimentIntegrationTests.swift
//  UseCaseIntegrationTests
//
//  Created by Anderson Chagas on 08/08/21.
//

import XCTest
import Domain
import Infra
import Data

class AnalyzeSentimentIntegrationTests: XCTestCase {

    func test_analize_sentiment() {
        let apiKey = "AIzaSyBPAFYc-pTL9uU-a4xVeRGmmmn_kYQPfEs"
        let baseUrl = "https://language.googleapis.com/v1/documents:analyzeSentiment"
        var urlComponents = URLComponents(string: baseUrl)
        urlComponents?.queryItems = [URLQueryItem(name: "key", value: apiKey)]
        let url = urlComponents!.url!.absoluteURL
        
        let model = FetchAnalyzeSentimentModel(document: Document(content: "Happy Birthday!"))

        let alamofire = AlamofireAdapter()
        let analizySentiment = RemoteAnalyzeSentiment(url: url, httpClient: alamofire)

        let exp = expectation(description: "waiting")
        analizySentiment.fetchAnalyzeSentiment(fetchTweetTimeLineModel: model) { result in
            switch result {
            case .failure: XCTFail("Expect success got \(result) instead")
            case .success(let model):
                XCTAssertNotNil(model)
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 10)
    }

}

