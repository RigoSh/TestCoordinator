//
//  AppFactory.swift
//  ThemoviedbOne
//
//  Created by ishuvalov on 13.12.2022.
//  Copyright © 2022 jonfir. All rights reserved.
//

import UIKit

protocol AppFactory {
    func makeKeyWindowWithCoordinator() -> (UIWindow, Coordinator)
}

final class AppFactoryImpl: AppFactory {
    private let coordinatorFactory: CoordinatorFactory

    init(coordinatorFactory: CoordinatorFactory) {
        self.coordinatorFactory = coordinatorFactory
    }

    func makeKeyWindowWithCoordinator() -> (UIWindow, Coordinator) {
        let window = UIWindow()
        let rootVC = UINavigationController()
        rootVC.navigationBar.prefersLargeTitles = false
        let router = RouterImp(rootController: rootVC)
        let cooridnator = coordinatorFactory.makeApplicationCoordinator(router: router)
        window.rootViewController = rootVC
        return (window, cooridnator)
    }
}
