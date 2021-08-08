//
//  HttpGetClient.swift
//  Data
//
//  Created by Anderson Chagas on 07/08/21.
//

import Foundation

public protocol HttpClient {
    func request(to url: URL, method: HttpMethod, params: [String: Any]?, headers: [String: String]?, completion: @escaping (Result<Data?, HttpError>) -> Void)
}
