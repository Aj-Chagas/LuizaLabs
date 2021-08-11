//
//  RemoteTwitterProfile.swift
//  Data
//
//  Created by Anderson Chagas on 07/08/21.
//

import Foundation
import Domain

public final class RemoteTwitterProfile: TwitterProfile {
    
    private let url: URL
    private let header: [String: String]
    private let httpGetClient: HttpClient
    
    public init(url: URL, httpGetClient: HttpClient, header: [String: String]) {
        self.url = url
        self.httpGetClient = httpGetClient
        self.header = header
    }

    public func fetchTwitterProfile(fetchTwitterProfileModel model: FetchTwitterProfileModel,
                             completion: @escaping (TwitterProfile.Result) -> Void) {
        guard let url = makeTwitterProfileUrl(model, completion: completion) else {
            return
        }
        httpGetClient.request(to: url, method: .get, body: nil, headers: header) { result in
            switch result {
            case .success(let data):
                if let model: TwitterProfileModel = data?.toModel() {
                    completion(.success(model))
                } else {
                    completion(.failure(.userNameNotFound))
                }
            case .failure: completion(.failure(.unexpected))
            }
        }
    }

    public func makeTwitterProfileUrl(_ path: FetchTwitterProfileModel,
                                      completion: @escaping (TwitterProfile.Result) -> Void) -> URL? {
        guard let newUrl = URL(string: "\(url.absoluteString)\(path.userName)") else {
            completion(.failure(.invalidUserName))
            return nil
        }
        return newUrl
    }
    
}
