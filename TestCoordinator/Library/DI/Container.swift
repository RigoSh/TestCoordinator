//
//  Container.swift
//  TestCoordinator
//
//  Created by ishuvalov on 13.12.2022.
//

import UIKit

final class Container {
    let coordinatorFactory: CoordinatorFactory
    let screenFactory: ScreenFactory
    let managerFactory: ManagerFactory
    let tabbarFactory: TabbarFactory

    init() {
        let screenFactory = ScreenFactoryImpl()
        self.screenFactory = screenFactory
        self.tabbarFactory = TabbarFactoryImpl()
        self.coordinatorFactory = CoordinatorFactoryImp(
            screenFactory: screenFactory,
            tabbarFactory: tabbarFactory
        )
        self.managerFactory = ManagerFactoryImpl()
        screenFactory.container = self
    }
}

extension Container: AppFactory {
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
