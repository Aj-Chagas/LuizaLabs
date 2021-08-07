//
//  DataExtension.swift
//  Data
//
//  Created by Anderson Chagas on 07/08/21.
//

import Foundation

extension Data {
    func toModel<T: Decodable>() -> T? {
        try? JSONDecoder().decode(T.self, from: self)
    }
}
