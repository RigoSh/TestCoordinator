//
//  TabbarCoordinator.swift
//  TestCoordinator
//
//  Created by ishuvalov on 14.12.2022.
//  Copyright © 2022 jonfir. All rights reserved.
//

import UIKit

protocol TabbarCoordinatorOutput: AnyObject {
    var finishFlow: VoidClosure? { get set }
}

class TabbarCoordinator: BaseCoordinator, TabbarCoordinatorOutput {
    var finishFlow: VoidClosure?
    private let coordinatorFactory: CoordinatorFactory

    init(coordinatorFactory: CoordinatorFactory) {
        self.coordinatorFactory = coordinatorFactory
    }

    func configure(with tabbarController: TabbarController) {
        tabbarController.onViewWillAppear = runMonitoringFlow
        tabbarController.onMonitoringFlowSelect = runMonitoringFlow
        tabbarController.onProfileFlowSelect = runProfileFlow
    }
}

private extension TabbarCoordinator {
    func runMonitoringFlow(rootController: UIViewController) {
        guard let navController = getEmptyNavigationController(from: rootController) else {
            return
        }

        let router = RouterImp(rootController: navController)
        let coordinator = coordinatorFactory.makeMonitoringCoordinator(router: router)
        coordinator.finishFlow = { [weak self] in
            self?.finishFlow?()
        }
        self.addDependency(coordinator)
        coordinator.start()
    }

    func runProfileFlow(rootController: UIViewController) {
        guard let navController = getEmptyNavigationController(from: rootController) else {
            return
        }

        let router = RouterImp(rootController: navController)
        let coordinator = coordinatorFactory.makeProfileCoordinator(router: router)
        self.addDependency(coordinator)
        coordinator.start()
    }

    func getEmptyNavigationController(from controller: UIViewController) -> UINavigationController? {
        if let navController = controller as? UINavigationController,
           navController.viewControllers.isEmpty  {
            return navController
        } else {
            return nil
        }
    }
}
