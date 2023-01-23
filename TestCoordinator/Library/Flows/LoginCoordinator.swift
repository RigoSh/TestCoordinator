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

final class LoginCoordinator: Coordinator, LoginCoordinatorOutput {
    var childCoordinators: [Coordinator]
    var finishFlow: VoidClosure?

    private let screenFactory: ScreenFactory
    private let router: Router

    init(router: Router, screenFactory: ScreenFactory) {
        self.childCoordinators = []
        self.screenFactory = screenFactory
        self.router = router
    }

    func start(step: Step) {
        showLogin(hideNavBar: true)
    }

    private func showLogin(hideNavBar: Bool) {
        let screen = screenFactory.makeLoginScreen(hideNavBar: hideNavBar) { [weak self] in
            self?.finishFlow?()
        }
        router.setRootModule(screen, hideNavBar: hideNavBar)
    }
}
