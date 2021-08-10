//
//  TestFactories.swift
//  PresentationTests
//
//  Created by Anderson Chagas on 09/08/21.
//

import Foundation
import Presentation

func makeSearchTwitterRequest(userName: String = "any_name") -> SearchTwitterRequest {
    SearchTwitterRequest(userName: userName)
}
