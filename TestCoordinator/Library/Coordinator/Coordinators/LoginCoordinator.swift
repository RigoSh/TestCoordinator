//
//  LoginCoordinator.swift
//  TestCoordinator
//
//  Created by ishuvalov on 13.12.2022.
//

import Foundation

final class LoginCoordinator: BaseCoordinator {
    var finishFlow: VoidClosure?

    private let screenFactory: ScreenFactory
    private let router: Router

    init(router: Router, screenFactory: ScreenFactory) {
        self.screenFactory = screenFactory
        self.router = router
    }

    override func start() {
        showLogin()
    }

    private func showLogin() {
        let screen = screenFactory.makeLoginScreen { [weak self] in
            self?.finishFlow?()
        }
        router.setRootModule(screen, hideBar: true)
    }
}
