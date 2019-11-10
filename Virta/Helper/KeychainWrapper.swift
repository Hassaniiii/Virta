//
//  KeychainWrapper.swift
//  Virta
//
//  Created by Hassaniiii on 11/8/19.
//  Copyright © 2019 Hassaniiii. All rights reserved.
//

import KeychainSwift

struct KeychainWrapepr {
    
    // MARK: - KeychainWrapper
    
    static func set(value: String, for key: String) {
        KeychainSwift().set(value, forKey: key)
    }
    
    static func getValue(for key: String) -> String? {
        return KeychainSwift().get(key)
    }
    
    static func reset() {
        KeychainSwift().clear()
    }
}
