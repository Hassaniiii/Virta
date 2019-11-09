//
//  UITableView+Extensions.swift
//  Virta
//
//  Created by Hassaniiii on 11/9/19.
//  Copyright © 2019 Hassaniiii. All rights reserved.
//

import UIKit

extension UITableView {
    func register<T: UITableViewCell>(_: T.Type) {
       let nib = UINib(nibName: String(describing: T.self), bundle: nil)
       self.register(nib, forCellReuseIdentifier: String(describing: T.self))
   }
    
    func registerClass<T: UITableViewCell>(_: T.Type) {
        self.register(T.self, forCellReuseIdentifier: String(describing: T.self))
    }
    
    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as? T else {
            fatalError("Error: Can't dequeue reussable cell with identifier: \(String(describing: T.self))!")
        }
        return cell
    }
}
