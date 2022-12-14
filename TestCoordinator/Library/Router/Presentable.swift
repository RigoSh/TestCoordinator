//
//  Presentable.swift
//  TestCoordinator
//
//  Created by ishuvalov on 13.12.2022.
//

import UIKit

protocol Presentable {
    func toPresent() -> UIViewController?
}

extension UIViewController: Presentable {
    func toPresent() -> UIViewController? {
        return self
    }
}
