//
//  RemoteTweetTimelineFactory.swift
//  Main
//
//  Created by Anderson Chagas on 11/08/21.
//

import Foundation
import Data

private let ktwitterProfileURL = "https://api.twitter.com/2/users/:id/tweets"
private let Kbearer = "Bearer AAAAAAAAAAAAAAAAAAAAAI7RSQEAAAAA6Xlma4v%2FZ%2BZ7pvlPE3rmOVkCias%3Dszrq8Ililogdj7Wh91OmYWyDjjQS3ftOpYBKBAgEVTjPjbCmS4"
private let kAuthorization = "Authorization"

func makeRemoteTweetTimeline() -> RemoteTweetTimeline {
    var urlComponents = URLComponents(string: ktwitterProfileURL)
    urlComponents?.queryItems = [URLQueryItem(name: "max_results", value: "100")]
    let url = urlComponents!.url!.absoluteURL
    return RemoteTweetTimeline(url: url, httpGetClient: makeAlamofireAdapter(), header: [kAuthorization: Kbearer])
}
