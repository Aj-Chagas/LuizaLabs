//
//  DomainError.swift
//  Domain
//
//  Created by Anderson Chagas on 07/08/21.
//

import Foundation

public enum DomainError: Error {
    case unexpected
    case userNameNotFound
    case invalidUserName
    case tweetsNotFound
}
