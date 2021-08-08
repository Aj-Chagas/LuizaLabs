//
//  HttpGetClientSpy.swift
//  DataTests
//
//  Created by Anderson Chagas on 07/08/21.
//

import Foundation
import Data

class HttpClientSpy: HttpClient {

    var urls = [URL]()
    var completion: ((Result<Data?, HttpError>) -> Void)?
    var params: [String : Any]?
    var headers: [String : String]?
    var method: HttpMethod?
    
    func request(to url: URL, method: HttpMethod, params: [String : Any]?, headers: [String : String]?, completion: @escaping (Result<Data?, HttpError>) -> Void) {
        self.urls.append(url)
        self.params = params
        self.completion = completion
        self.params = params
        self.headers = headers
        self.method = method
    }

    func completionWithError(_ httpError: HttpError = .noConnectivity) {
        completion?(.failure(httpError))
    }

    func completionWithSuccess(_ data: Data?) {
        completion?(.success(data))
    }

}
