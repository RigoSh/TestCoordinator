//
//  CoordinatorFactory.swift
//  ThemoviedbOne
//
//  Created by ishuvalov on 13.12.2022.
//  Copyright © 2022 jonfir. All rights reserved.
//

import Foundation

protocol CoordinatorFactory {
    func makeApplicationCoordinator(router: Router) -> Coordinator
    func makeTabbarCoordinator() -> (coordinator: Coordinator & TabbarCoordinatorOutput, toPresent: Presentable?)
    func makeLoginCoordinator(router: Router) -> Coordinator & LoginCoordinatorOutput
    func makeMonitoringCoordinator(router: Router) -> Coordinator & MonitoringCoordinatorOutput
    func makeProfileCoordinator(router: Router) -> Coordinator & ProfileCoordinatorOutput
}

final class CoordinatorFactoryImp: CoordinatorFactory {
    private let screenFactory: ScreenFactory
    private let tabbarFactory: TabbarFactory

    init(screenFactory: ScreenFactory, tabbarFactory: TabbarFactory){
        self.screenFactory = screenFactory
        self.tabbarFactory = tabbarFactory
    }

    func makeApplicationCoordinator(router: Router) -> Coordinator {
        ApplicationCoordinator(router: router, coordinatorFactory: self)
    }

    func makeTabbarCoordinator() -> (coordinator: Coordinator & TabbarCoordinatorOutput, toPresent: Presentable?) {
        let controller = tabbarFactory.makeTabbarController()
        let coordinator = TabbarCoordinator(coordinatorFactory: self)
        coordinator.configure(with: controller)
        return (coordinator, controller)
    }

    func makeMonitoringCoordinator(router: Router) -> Coordinator & MonitoringCoordinatorOutput {
        MonitoringCoordinator(router: router, screenFactory: screenFactory)
    }

    func makeLoginCoordinator(router: Router) -> Coordinator & LoginCoordinatorOutput {
        LoginCoordinator(router: router, screenFactory: screenFactory)
    }

    func makeProfileCoordinator(router: Router) -> Coordinator & ProfileCoordinatorOutput {
        ProfileCoordinator(router: router, screenFactory: screenFactory)
    }
}
