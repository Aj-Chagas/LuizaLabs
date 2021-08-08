//
//  HttpGetClientSpy.swift
//  DataTests
//
//  Created by Anderson Chagas on 07/08/21.
//

import Foundation
import Data

class HttpGetClientSpy: HttpGetClient {

    var urls = [URL]()
    var completion: ((Result<Data?, HttpError>) -> Void)?
    var params: [String : Any]?
    var headers: [String : String]?

    func get(to url: URL, params: [String : Any]?, headers: [String : String]?, completion: @escaping (Result<Data?, HttpError>) -> Void) {
        self.urls.append(url)
        self.params = params
        self.completion = completion
        self.params = params
        self.headers = headers
    }

    func completionWithError(_ httpError: HttpError = .noConnectivity) {
        completion?(.failure(httpError))
    }

    func completionWithSuccess(_ data: Data?) {
        completion?(.success(data))
    }

}
