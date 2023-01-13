//
//  ApplicationCoordinator.swift
//  TestCoordinator
//
//  Created by ishuvalov on 13.12.2022.
//

import Foundation

final class ApplicationCoordinator: BaseCoordinator {
    var childCoordinators: [Coordinator]

    private let coordinatorFactory: CoordinatorFactory
    private let router: Router

    private var isAuthenticated = false

    init(router: Router, coordinatorFactory: CoordinatorFactory) {
        self.childCoordinators = []
        self.router = router
        self.coordinatorFactory = coordinatorFactory
    }
}

extension ApplicationCoordinator {
    func start(step: Step) {
        if isAuthenticated {
            handle(step: step)
        } else {
            runLoginFlow(backStep: step)
        }
    }

    func handle(appStep: AppStep) {
        switch appStep {
        case .main:
            runMainFlow(step: AppStep.monitoringTab)
        case .auth:
            runLoginFlow(backStep: AppStep.main)
        default:
            print("Handling unpredictable appStep: \(appStep) for \(type(of: self))")
        }
    }

    func handle(deeplinkStep: DeeplinkStep) {
        runMainFlow(step: deeplinkStep)
    }
}

private extension ApplicationCoordinator {
    func runLoginFlow(backStep: Step) {
        let coordinator = coordinatorFactory.makeLoginCoordinator(router: router)
        coordinator.finishFlow = { [weak self, weak coordinator] in
            self?.removeCoordinator(coordinator)
            self?.isAuthenticated = true
            self?.start(step: backStep)
        }
        addCoordinator(coordinator)
        coordinator.start(step: backStep)
    }

    func runMainFlow(step: Step) {
        let coordinator = coordinatorFactory.makeTabbarCoordinator(router: router)
        coordinator.finishFlow = { [weak self, weak coordinator] in
            self?.removeCoordinator(coordinator)
            self?.isAuthenticated = false
            self?.start(step: AppStep.main)
        }
        addCoordinator(coordinator)
        coordinator.start(step: step)
    }
}
