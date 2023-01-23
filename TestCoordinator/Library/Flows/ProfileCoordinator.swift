//
//  ProfileCoordinator.swift
//  TestCoordinator
//
//  Created by ishuvalov on 14.12.2022.
//  Copyright © 2022 jonfir. All rights reserved.
//

import Combine
import Foundation

protocol ProfileCoordinatorOutput: AnyObject {
    var finishFlow: VoidClosure? { get set }
}

final class ProfileCoordinator: BaseCoordinator, ProfileCoordinatorOutput {
    var childCoordinators: [Coordinator]
    var finishFlow: VoidClosure?

    private let router: Router
    private let screenFactory: ScreenFactory
    private let action: AnyPublisher<ProfileCoordinatorInputAction, Never>

    private var cancelBag = Set<AnyCancellable>()

    init(
        router: Router,
        screenFactory: ScreenFactory,
        action: AnyPublisher<ProfileCoordinatorInputAction, Never>
    ) {
        self.childCoordinators = []
        self.router = router
        self.screenFactory = screenFactory
        self.action = action
        subscribeAction()
    }

    func start(step: Step) {
        showProfile(hideNavBar: false)
    }

    func handle(appStep: AppStep) {
        switch appStep {
        case .profileDetail:
            showProfileDetail(hideNavBar: true, hideBottomBar: true)
        default:
            print("Handling unpredictable appStep: \(appStep) for \(type(of: self))")
        }
    }

    private func showProfile(hideNavBar: Bool) {
        let screen = screenFactory.makeProfileScreen(
            hideNavBar: hideNavBar,
            detailHandler: { [weak self] in
                self?.handle(appStep: .profileDetail)
            }
        )
        router.setRootModule(screen, hideNavBar: hideNavBar)
    }

    private func showProfileDetail(hideNavBar: Bool, hideBottomBar: Bool) {
        let screen = screenFactory.makeProfileDetailScreen(
            hideNavBar: hideNavBar,
            backHandler: { [weak self] in
                self?.router.popModule()
            }
        )
        router.push(screen, animated: true, hideBottomBar: hideBottomBar, completion: {})
    }

    private func subscribeAction() {
        action
            .sink { [weak self] action in
                switch action {
                case .profileDetail:
                    self?.handle(appStep: .profileDetail)
                }
            }
            .store(in: &cancelBag)
    }
}

enum ProfileCoordinatorInputAction {
    case profileDetail
}
