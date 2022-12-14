//
//  Container.swift
//  TestCoordinator
//
//  Created by ishuvalov on 13.12.2022.
//

import UIKit

final class Container {
    let coordinatorFactory: CoordinatorFactory
    let screenFactory: ScreenFactoryImpl
    let managerFactory: ManagerFactory

    init() {
        screenFactory = ScreenFactoryImpl()
        coordinatorFactory = CoordinatorFactoryImp(screenFactory: screenFactory)
        managerFactory = ManagerFactoryImpl()
        screenFactory.container = self
    }
}

extension Container: AppFactory {
    func makeKeyWindowWithCoordinator() -> (UIWindow, Coordinator) {
        let window = UIWindow()
        let rootVC = UINavigationController()
        rootVC.navigationBar.prefersLargeTitles = true
        let router = RouterImp(rootController: rootVC)
        let cooridnator = coordinatorFactory.makeApplicationCoordinator(router: router)
        window.rootViewController = rootVC
        return (window, cooridnator)
    }
}
