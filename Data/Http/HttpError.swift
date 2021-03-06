//
//  HttpError.swift
//  Data
//
//  Created by Anderson Chagas on 07/08/21.
//

import Foundation

public enum HttpError: Error {
    case noConnectivity
    case badRequest
    case serverError
    case unauthorized
    case forbideen
}
