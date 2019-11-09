//
//  ServiceManager.swift
//  Ninchat
//
//  Created by Hassaniiii on 10/25/19.
//  Copyright © 2019 Hassaniiii. All rights reserved.
//

import Foundation
import Combine

protocol ServiceManager {
    func performRequest<T: Request>(_ request: T) -> AnyPublisher<T.ReturnType, APIError>
}

final class ServiceManagerImpl: ServiceManager, ObservableObject {
    private let session = URLSession.shared
    
    func performRequest<T>(_ request: T) -> AnyPublisher<T.ReturnType, APIError> where T : Request {
        session.dataTaskPublisher(for: self.urlRequest(request))
            .tryMap { data, response in
                try self.validateResponse(data, response)
                return data
            }
            .decode(type: T.ReturnType.self, decoder: JSONDecoder())
            .mapError { error in
                self.transformError(error)
            }
            .eraseToAnyPublisher()
    }
    
    private func validateResponse(_ data: Data, _ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse, 200 ... 299 ~= httpResponse.statusCode else {
            throw try JSONDecoder().decode(APIError.self, from: data)
        }
    }
    
    private func transformError(_ error: Error) -> APIError {
        if let apiError = error as? APIError {
            return apiError
        }
        let nserror = error as NSError
        return APIError(statusCode: nserror.code, message: nserror.localizedDescription, errorCode: nserror.code)
    }

    
    private func urlRequest<T: Request>(_ request: T, cache: URLRequest.CachePolicy = .useProtocolCachePolicy) -> URLRequest {
        guard let url = URL(string: "\(request.host)\(request.path)") else {
            fatalError("ERROR! Cannot generate the URL")
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        if request.httpMethod != .get {
            // to prevent error code -1103 on iOS
            urlRequest.httpBody = request.body
        }
        urlRequest.cachePolicy = cache

        return urlRequest
    }
}
