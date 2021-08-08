//
//  UseCaseIntegrationTests.swift
//  UseCaseIntegrationTests
//
//  Created by Anderson Chagas on 07/08/21.
//

import XCTest
import Domain
import Infra
import Data

class UseCaseIntegrationTests: XCTestCase {

    func test() {        
        let url = URL(string: "https://api.twitter.com/2/users/by/username/")!
        let headers: [String: String] = ["Authorization": "Bearer AAAAAAAAAAAAAAAAAAAAAI7RSQEAAAAA6Xlma4v%2FZ%2BZ7pvlPE3rmOVkCias%3Dszrq8Ililogdj7Wh91OmYWyDjjQS3ftOpYBKBAgEVTjPjbCmS4",
                                         "Content-Type": "application/json"]

        let urlSession = AlamofireAdapter()
        let twitterProfile = RemoteTwitterProfile(url: url, httpGetClient: urlSession, header: headers)

        let exp = expectation(description: "waiting")
        twitterProfile.fetchTwitterProfile(fetchTwitterProfileModel: FetchTwitterProfileModel(userName: "BRKsEDU")) { result in
            switch result {
            case .failure: XCTFail("Expect success got \(result) instead")
            case .success(let news):
                XCTAssertNotNil(news)
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 10)
    }

}
