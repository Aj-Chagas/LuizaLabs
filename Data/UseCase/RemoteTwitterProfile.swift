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
    private let httpGetClient: HttpGetClient
    
    public init(url: URL, httpGetClient: HttpGetClient, header: [String: String]) {
        self.url = url
        self.httpGetClient = httpGetClient
        self.header = header
    }

    public func fetchTwitterProfile(fetchTwitterProfileModel: FetchTwitterProfileModel,
                             completion: @escaping (TwitterProfile.Result) -> Void) {
        httpGetClient.get(to: url, params: nil, headers: header) { result in
            switch result {
            case .success(let data):
                if let model: TwitterProfileModel = data?.toModel() {
                    completion(.success(model))
                } else {
                    completion(.failure(.unexpected))
                }
            case .failure: completion(.failure(.unexpected))
            }
            
        }
    }
    
}
