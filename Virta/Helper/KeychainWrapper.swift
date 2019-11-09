//
//  KeychainWrapper.swift
//  Virta
//
//  Created by Hassaniiii on 11/8/19.
//  Copyright © 2019 Hassaniiii. All rights reserved.
//

import KeychainSwift

protocol KeychainWrapper {
    func set(value: String, for key: String)
    func getValue(for key: String) -> String?
}

struct KeychainWrapeprImpl: KeychainWrapper {
    
    private let keychain = KeychainSwift()
    
    // MARK: - KeychainWrapper
    
    func set(value: String, for key: String) {
        keychain.set(value, forKey: key)
    }
    func getValue(for key: String) -> String? {
        return keychain.get(key)
    }
}
