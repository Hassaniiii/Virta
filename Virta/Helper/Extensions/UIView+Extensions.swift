//
//  UIView+Extensions.swift
//  Virta
//
//  Created by Hassaniiii on 11/9/19.
//  Copyright © 2019 Hassaniiii. All rights reserved.
//

import UIKit

extension UIView {
    static func `init`(_ backgroundColor: UIColor) -> UIView {
        let view = UIView()
        view.backgroundColor = backgroundColor
        
        return view
    }
}
