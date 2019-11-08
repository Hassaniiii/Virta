//
//  Storyboard.swift
//  Virta
//
//  Created by Hassaniiii on 11/8/19.
//  Copyright © 2019 Hassaniiii. All rights reserved.
//

import UIKit

enum Storyboard: String {
    case main = "Main"
    
    func instantiateViewController<T: ViewController>() -> T {
        let storyboard = UIStoryboard(name: rawValue, bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: String(describing: T.self)) as? T else {
            fatalError("Failed to load \(String(describing: T.self)) from \(storyboard).storyboard")
        }
        return viewController
    }
}


