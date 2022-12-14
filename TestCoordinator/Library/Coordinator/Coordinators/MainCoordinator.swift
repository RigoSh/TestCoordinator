//
//  MainCoordinator.swift
//  ThemoviedbOne
//
//  Created by ishuvalov on 13.12.2022.
//  Copyright © 2022 jonfir. All rights reserved.
//

import Foundation

final class MainCoordinator: BaseCoordinator {
    var finishFlow: VoidClosure?

    private let screenFactory: ScreenFactory
    private let router: Router

    init(router: Router, screenFactory: ScreenFactory) {
        self.screenFactory = screenFactory
        self.router = router
    }

    override func start() {
        showMain()
    }

    private func showMain() {
        let screen = screenFactory.makeMainScreen(
            backHandler: { [weak self] in
                self?.finishFlow?()
            }, infoHandler: { [weak self] in
                self?.showInfo()
            }
        )
        router.setRootModule(screen, hideBar: false)
    }

    private func showInfo() {
        let screen = screenFactory.makeInfoScreen(
            backHandler: { [weak self] in
                self?.router.popModule()
            }, logoutHandler: { [weak self] in
                self?.finishFlow?()
            }
        )
        router.push(screen, hideBottomBar: true)
    }
}
