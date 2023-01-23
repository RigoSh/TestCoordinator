//
//  MonitoringCoordinator.swift
//  ThemoviedbOne
//
//  Created by ishuvalov on 13.12.2022.
//  Copyright © 2022 jonfir. All rights reserved.
//

import Foundation

protocol MonitoringCoordinatorOutput: AnyObject {
    var finishFlow: VoidClosure? { get set }
    var profileHandler: VoidClosure? { get set }
}

final class MonitoringCoordinator: BaseCoordinator, MonitoringCoordinatorOutput {
    var childCoordinators: [Coordinator]
    var finishFlow: VoidClosure?
    var profileHandler: VoidClosure?

    private let screenFactory: ScreenFactory
    private let router: Router

    init(router: Router, screenFactory: ScreenFactory) {
        self.childCoordinators = []
        self.router = router
        self.screenFactory = screenFactory
    }

    func handle(appStep: AppStep) {
        switch appStep {
        case .monitoring:
            showMonitoring(hideNavBar: false)
        case .monitoringInfo:
            showInfo(hideNavBar: false, hideBottomBar: false)
        default:
            print("Handling unpredictable appStep: \(appStep) for \(type(of: self))")
        }
    }

    func handle(deeplinkStep: DeeplinkStep) {
        switch deeplinkStep {
        case .monitoringInfo:
            handle(appStep: .monitoring)
            handle(appStep: .monitoringInfo)
        default:
            print("Handling unpredictable deeplinkStep: \(deeplinkStep) for \(type(of: self))")
        }
    }

    private func showMonitoring(hideNavBar: Bool) {
        let screen = screenFactory.makeMonitoringScreen(
            hideNavBar: hideNavBar,
            logoutHandler: { [weak self] in
                self?.finishFlow?()
            },
            infoHandler: { [weak self] in
                self?.handle(step: AppStep.monitoringInfo)
            },
            profileHandler: { [weak self] in
                self?.profileHandler?()
            }
        )
        router.setRootModule(screen, hideNavBar: hideNavBar)
    }

    private func showInfo(hideNavBar: Bool, hideBottomBar: Bool) {
        let screen = screenFactory.makeInfoScreen(
            hideNavBar: hideNavBar,
            backHandler: { [weak self] in
                self?.router.popModule()
            }, logoutHandler: { [weak self] in
                self?.finishFlow?()
            }
        )
        router.push(screen, animated: true, hideBottomBar: hideBottomBar, completion: {})
    }
}
