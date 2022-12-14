//
//  ProfileCoordinator.swift
//  TestCoordinator
//
//  Created by ishuvalov on 14.12.2022.
//  Copyright © 2022 jonfir. All rights reserved.
//

import Foundation

protocol ProfileCoordinatorOutput: AnyObject {
    var finishFlow: VoidClosure? { get set }
}

final class ProfileCoordinator: BaseCoordinator, ProfileCoordinatorOutput {
    var finishFlow: VoidClosure?

    private let screenFactory: ScreenFactory
    private let router: Router

    init(router: Router, screenFactory: ScreenFactory) {
        self.screenFactory = screenFactory
        self.router = router
    }

    override func start() {
        showProfile(hideBar: false)
    }

    private func showProfile(hideBar: Bool) {
        let screen = screenFactory.makeProfileScreen(hideBar: hideBar)
        router.setRootModule(screen, hideBar: hideBar)
    }
}