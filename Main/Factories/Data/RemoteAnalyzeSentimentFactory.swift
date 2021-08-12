//
//  RemoteAnalyzeSentimentFactory.swift
//  Main
//
//  Created by Anderson Chagas on 11/08/21.
//

import Foundation
import Data

private let apiKey = "AIzaSyBPAFYc-pTL9uU-a4xVeRGmmmn_kYQPfEs"
private let baseUrl = "https://language.googleapis.com/v1/documents:analyzeSentiment"

func makeRemoteAnalyzeSentiment() -> RemoteAnalyzeSentiment {
    var urlComponents = URLComponents(string: baseUrl)
    urlComponents?.queryItems = [URLQueryItem(name: "key", value: apiKey)]
    let url = urlComponents!.url!.absoluteURL
    return RemoteAnalyzeSentiment(url: url, httpClient: makeAlamofireAdapter())
}

