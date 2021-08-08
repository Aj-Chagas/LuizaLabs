//
//  HttpPostClient.swift
//  Data
//
//  Created by Anderson Chagas on 08/08/21.
//

import Foundation

public protocol HttpPostClient {
    func post(to url: URL, params: [String: Any]?, completion: @escaping (Result<Data?, HttpError>) -> Void)
}
