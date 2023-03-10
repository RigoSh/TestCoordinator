//
//  Container.swift
//  TestCoordinator
//
//  Created by ishuvalov on 13.12.2022.
//

import UIKit

final class Container {
    let appFactory: AppFactory
    let coordinatorFactory: CoordinatorFactory
    let screenFactory: ScreenFactory
    let managerFactory: ManagerFactory
    let tabbarFactory: TabbarFactory

    init() {
        let screenFactory = ScreenFactoryImpl()
        self.screenFactory = screenFactory
        self.tabbarFactory = TabbarFactoryImpl()

        let coordinatorFactory = CoordinatorFactoryImp(
            screenFactory: screenFactory,
            tabbarFactory: tabbarFactory
        )
        self.coordinatorFactory = coordinatorFactory
        self.appFactory = AppFactoryImpl(coordinatorFactory: coordinatorFactory)
        self.managerFactory = ManagerFactoryImpl()

        screenFactory.container = self
    }
}
