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
            self?.removeDependency(coordinator)
            self?.isLogin = true
            self?.start()
        }
        addDependency(coordinator)
        coordinator.start()
    }

    func runMainFlow() {
        let (coordinator, module) = coordinatorFactory.makeTabbarCoordinator()
        coordinator.finishFlow = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
            self?.isLogin = false
            self?.start()
        }
        addDependency(coordinator)
        router.setRootModule(module, hideBar: true)
        coordinator.start()
    }
}
