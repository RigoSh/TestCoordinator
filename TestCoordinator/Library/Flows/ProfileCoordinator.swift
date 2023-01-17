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

final class ProfileCoordinator: Coordinator, ProfileCoordinatorOutput {
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
        showProfile(hideBar: false)
    }

    private func showProfile(hideBar: Bool) {
        let screen = screenFactory.makeProfileScreen(hideBar: hideBar)
        router.setRootModule(screen, hideBar: hideBar)
    }

    private func subscribeAction() {
        action
            .sink { action in
                switch action {
                case .changeInfo:
                    print("action: changeInfo")
                }
            }
            .store(in: &cancelBag)
    }
}

enum ProfileCoordinatorInputAction {
    case changeInfo
}
