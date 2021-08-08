//
//  TweetTimelineIntegrationTests.swift
//  UseCaseIntegrationTests
//
//  Created by Anderson Chagas on 08/08/21.
//

import XCTest
import Domain
import Infra
import Data
import Alamofire

class TweetTimelineIntegrationTests: XCTestCase {

    func test_tweet_timeline() {
        let url = URL(string: "https://api.twitter.com/2/users/:id/tweets?max_results=100")!
        let header: [String: String] = ["Authorization": "Bearer AAAAAAAAAAAAAAAAAAAAAI7RSQEAAAAA6Xlma4v%2FZ%2BZ7pvlPE3rmOVkCias%3Dszrq8Ililogdj7Wh91OmYWyDjjQS3ftOpYBKBAgEVTjPjbCmS4"]
        
        let params: Parameters = ["max_results": 100]
        let model = FetchTweetTimelineModel(id: "232447988")

        let alamofire = AlamofireAdapter()
        let twitterTimeline = RemoteTweetTimeline(url: url, httpGetClient: alamofire, params: params, header: header)

        let exp = expectation(description: "waiting")
        twitterTimeline.fetchTweetTimeLine(fetchTweetTimeLineModel: model){ result in
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

