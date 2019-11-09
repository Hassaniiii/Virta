//
//  String+NSLocalized.swift
//  Virta
//
//  Created by Hassaniiii on 11/9/19.
//  Copyright © 2019 Hassaniiii. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
