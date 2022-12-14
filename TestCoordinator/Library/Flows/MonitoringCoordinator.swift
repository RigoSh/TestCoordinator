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
}

final class MonitoringCoordinator: BaseCoordinator, MonitoringCoordinatorOutput {
    var finishFlow: VoidClosure?

    private let screenFactory: ScreenFactory
    private let router: Router

    init(router: Router, screenFactory: ScreenFactory) {
        self.screenFactory = screenFactory
        self.router = router
    }

    override func start() {
        showMonitoring(hideBar: true)
    }

    private func showMonitoring(hideBar: Bool) {
        let screen = screenFactory.makeMonitoringScreen(
            hideBar: hideBar,
            backHandler: { [weak self] in
                self?.finishFlow?()
            }, infoHandler: { [weak self] in
                self?.showInfo(hideBar: true, hideBottomBar: true)
            }
        )
        router.setRootModule(screen, hideBar: hideBar)
    }

    private func showInfo(hideBar: Bool, hideBottomBar: Bool) {
        let screen = screenFactory.makeInfoScreen(
            hideBar: hideBar,
            backHandler: { [weak self] in
                self?.router.popModule()
            }, logoutHandler: { [weak self] in
                self?.finishFlow?()
            }
        )
        router.push(screen, hideBottomBar: hideBottomBar)
    }
}
