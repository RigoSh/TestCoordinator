//
//  BaseCoordinator.swift
//  TestCoordinator
//
//  Created by ishuvalov on 16.12.2022.
//  Copyright © 2022 jonfir. All rights reserved.
//

import Foundation

protocol BaseCoordinator: Coordinator {
    var childCoordinators: [Coordinator] { get set }

    func start(step: Step)
    func handle(step: Step)
    func handle(appStep: AppStep)
    func handle(deeplinkStep: DeeplinkStep)

    func addCoordinator(_ coordinator: Coordinator)
    func removeCoordinator(_ coordinator: Coordinator?)
}

extension BaseCoordinator {
    func start(step: Step) {
        handle(step: step)
    }

    func handle(step: Step) {
        switch step {
        case let appStep as AppStep:
            handle(appStep: appStep)
        case let deeplinkStep as DeeplinkStep:
            handle(deeplinkStep: deeplinkStep)
        default:
            print("Handling unpredictable type of step: \(step) for \(type(of: self))")
        }
    }

    func handle(appStep: AppStep) {}
    func handle(deeplinkStep: DeeplinkStep) {}

    func addCoordinator(_ coordinator: Coordinator) {
        guard !childCoordinators.contains(where: { $0 === coordinator }) else {
            return
        }

        childCoordinators.append(coordinator)
    }

    func removeCoordinator(_ coordinator: Coordinator?) {
        guard
            let coordinator = coordinator as? BaseCoordinator,
            !childCoordinators.isEmpty
        else {
            return
        }

        coordinator.childCoordinators
            .filter { $0 !== coordinator }
            .forEach { coordinator.removeCoordinator($0) }

        if let index = childCoordinators.firstIndex(where: { $0 === coordinator }) {
            childCoordinators.remove(at: index)
        }
    }
}
