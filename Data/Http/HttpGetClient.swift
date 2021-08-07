//
//  HttpGetClient.swift
//  Data
//
//  Created by Anderson Chagas on 07/08/21.
//

import Foundation

public protocol HttpGetClient {
    func get(to url: URL, with data: Data?, completion: @escaping (Result<Data?, HttpError>) -> Void)
}