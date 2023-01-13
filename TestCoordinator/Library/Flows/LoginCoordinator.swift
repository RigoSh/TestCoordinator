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
        showLogin(hideBar: true)
    }

    private func showLogin(hideBar: Bool) {
        let screen = screenFactory.makeLoginScreen(hideBar: hideBar) { [weak self] in
            self?.finishFlow?()
        }
        router.setRootModule(screen, hideBar: hideBar)
    }
}
