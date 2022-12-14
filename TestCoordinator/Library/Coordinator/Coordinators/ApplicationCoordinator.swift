//
//  ApplicationCoordinator.swift
//  TestCoordinator
//
//  Created by ishuvalov on 13.12.2022.
//

import Foundation

final class ApplicationCoordinator: BaseCoordinator {
    private let coordinatorFactory: CoordinatorFactory
    private let router: Router

    private var isLogin = false

    init(router: Router, coordinatorFactory: CoordinatorFactory) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
    }

    override func start() {
        if isLogin {
            runMainFlow()
        } else {
            runLoginFlow()
        }
    }
}

private extension ApplicationCoordinator {
    func runLoginFlow() {
        let coordinator = coordinatorFactory.makeLoginCoordinator(router: router)
        coordinator.finishFlow = { [weak self, weak coordinator] in
            self?.isLogin = true
            self?.start()
            self?.removeDependency(coordinator)
        }
        self.addDependency(coordinator)
        coordinator.start()
    }

    func runMainFlow() {
        let coordinator = coordinatorFactory.makeMainCoordinator(router: router)
        coordinator.finishFlow = { [weak self, weak coordinator] in
            self?.isLogin = false
            self?.start()
            self?.removeDependency(coordinator)
        }
        self.addDependency(coordinator)
        coordinator.start()
    }
}
