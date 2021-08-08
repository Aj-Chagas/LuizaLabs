//
//  DictionaryExtensions.swift
//  Infra
//
//  Created by Anderson Chagas on 07/08/21.
//

import Foundation
import Alamofire

extension Dictionary where Key == String, Value == String {
    func toHeaders() -> HTTPHeaders {
        let result = HTTPHeaders(self)
        return result
    }
}
