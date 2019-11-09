//
//  LoginRequest.swift
//  Virta
//
//  Created by Hassaniiii on 11/9/19.
//  Copyright © 2019 Hassaniiii. All rights reserved.
//

import Foundation

struct LoginRequest: Request {
    typealias ReturnType = LoginModel
    typealias BodyType = LoginRequestBody
    
    var path: String = "/auth"
    var httpMethod: HTTPMethod = .post
    var headers: [String : String]? = RequestHeaderImpl().headers
    var bodyJSON: BodyType?
    
    init(username: String, password: String) {
        bodyJSON = LoginRequestBody(email: username, code: password)
    }
    
    struct LoginRequestBody: Encodable {
        let email: String
        let code: String
    }
}
