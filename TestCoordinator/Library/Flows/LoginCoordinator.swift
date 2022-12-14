//
//  LoginCoordinator.swift
//  TestCoordinator
//
//  Created by ishuvalov on 13.12.2022.
//

import Foundation

protocol LoginCoordinatorOutput: AnyObject {
    var finishFlow: VoidClosure? { get set }
}

final class LoginCoordinator: BaseCoordinator, LoginCoordinatorOutput {
    var finishFlow: VoidClosure?

    private let screenFactory: ScreenFactory
    private let router: Router

    init(router: Router, screenFactory: ScreenFactory) {
        self.screenFactory = screenFactory
        self.router = router
    }

    override func start() {
        showLogin(hideBar: true)
    }

    private func showLogin(hideBar: Bool) {
        let screen = screenFactory.makeLoginScreen(hideBar: hideBar) { [weak self] in
            self?.finishFlow?()
        }
        router.setRootModule(screen, hideBar: hideBar)
    }
}
