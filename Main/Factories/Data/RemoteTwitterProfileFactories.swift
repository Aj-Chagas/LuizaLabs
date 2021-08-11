//
//  DataFactories.swift
//  Main
//
//  Created by Anderson Chagas on 11/08/21.
//

import Foundation
import Data

private let twitterProfileURL = "https://api.twitter.com/2/users/by/username/"
private let Kbearer = "Bearer AAAAAAAAAAAAAAAAAAAAAI7RSQEAAAAA6Xlma4v%2FZ%2BZ7pvlPE3rmOVkCias%3Dszrq8Ililogdj7Wh91OmYWyDjjQS3ftOpYBKBAgEVTjPjbCmS4"
private let kAuthorization = "Authorization"

func makeRemoteTwitterProfile() -> RemoteTwitterProfile {
    RemoteTwitterProfile(url: URL(string: twitterProfileURL)!, httpGetClient: makeAlamofireAdapter(), header: [kAuthorization: Kbearer])
}
