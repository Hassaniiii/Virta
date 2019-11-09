//
//  Result.swift
//  Ninchat
//
//  Created by Hassaniiii on 10/25/19.
//  Copyright © 2019 Hassaniiii. All rights reserved.
//

import Foundation

struct APIError: Codable, Error {
    let statusCode: Int
    let message: String
    let errorCode: Int

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message
        case errorCode = "error_code"
    }
}
