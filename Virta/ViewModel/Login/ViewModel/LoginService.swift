//
//  LoginService.swift
//  Virta
//
//  Created by Hassaniiii on 11/9/19.
//  Copyright © 2019 Hassaniiii. All rights reserved.
//

import Combine

protocol LoginService {
    func login(username: String, password: String) -> AnyPublisher<LoginModel, APIError>
}

struct LoginServiceImpl: LoginService {
    
    let service: ServiceManager = ServiceManagerImpl()
    
    func login(username: String, password: String) -> AnyPublisher<LoginModel, APIError> {
        let request = LoginRequest(username: username, password: password)
        return service.performRequest(request)
    }
}
