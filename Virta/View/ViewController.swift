//
//  ViewController.swift
//  Virta
//
//  Created by Hassaniiii on 11/8/19.
//  Copyright © 2019 Hassaniiii. All rights reserved.
//

import UIKit

protocol ViewController: UIViewController {
    var backgroundColor: UIColor { set get }
}

extension ViewController {
    var backgroundColor: UIColor {
        set(newColor) {
            self.view.backgroundColor = newColor
        }
        get {
            return self.view.backgroundColor ?? .clear
        }
    }
}
