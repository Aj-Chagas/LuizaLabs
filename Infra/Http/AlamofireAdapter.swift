//
//  URLSessionAdapter.swift
//  Infra
//
//  Created by Anderson Chagas on 07/08/21.
//

import Foundation
import Data
import Alamofire

public final class AlamofireAdapter: HttpClient {

    private let session: Session

    public init(session: Session = .default) {
        self.session = session
    }

    public func request(to url: URL, method: HttpMethod, params: [String : Any]?, headers: [String : String]?, completion: @escaping (Result<Data?, HttpError>) -> Void) {
        session.request(url, method: HTTPMethod(rawValue: method.rawValue), parameters: params, encoding: JSONEncoding.default, headers: headers?.toHeaders()).responseData { dataResponse in
            guard let statusCode = dataResponse.response?.statusCode else { return completion(.failure(.noConnectivity)) }
            switch dataResponse.result {
            case .failure: completion(.failure(.noConnectivity))
            case .success(let data):
                switch statusCode {
                case 200...299:
                    completion(.success(data))
                case 400...499:
                    completion(.failure(.badRequest))
                case 500...599:
                    completion(.failure(.serverError))
                default:
                    completion(.failure(.noConnectivity))
                }
            }
        }
    }

}
