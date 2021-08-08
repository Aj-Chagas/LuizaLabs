//
//  HttpPostClientSpy.swift
//  DataTests
//
//  Created by Anderson Chagas on 08/08/21.
//

import Foundation
import Data

class HttpPostClientSpy: HttpPostClient {

    var urls = [URL]()
    var params: [String : Any]?
    var completion: ((Result<Data?, HttpError>) -> Void)?
    
    
    func post(to url: URL, params: [String : Any]?, completion: @escaping (Result<Data?, HttpError>) -> Void) {
        self.urls.append(url)
        self.params = params
        self.completion = completion
    }

    func completionWithError(_ httpError: HttpError = .noConnectivity) {
        completion?(.failure(httpError))
    }

    func completionWithSuccess(_ data: Data?) {
        completion?(.success(data))
    }

}
