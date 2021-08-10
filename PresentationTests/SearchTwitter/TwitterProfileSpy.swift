//
//  TwitterProfileSpy.swift
//  PresentationTests
//
//  Created by Anderson Chagas on 09/08/21.
//

import Foundation
import Domain

class TwitterProfileSpy: TwitterProfile {

    var fetchTwitterProfileModel: FetchTwitterProfileModel?
    var completion: ((TwitterProfile.Result) -> Void)?
    
    func fetchTwitterProfile(fetchTwitterProfileModel: FetchTwitterProfileModel, completion: @escaping (TwitterProfile.Result) -> Void) {
        self.fetchTwitterProfileModel = fetchTwitterProfileModel
        self.completion = completion
    }
    
    func completionWithError(_ error: DomainError = .unexpected){
        completion?(.failure(error))
    }
    
    func completionWithSuccess(twitterProfileModel model: TwitterProfileModel) {
        completion?(.success(model))
    }

}
