//
//  CoordinatorFactory.swift
//  ThemoviedbOne
//
//  Created by ishuvalov on 13.12.2022.
//  Copyright © 2022 jonfir. All rights reserved.
//

import Foundation

protocol CoordinatorFactory {
    func makeApplicationCoordinator(router: Router) -> ApplicationCoordinator
    func makeLoginCoordinator(router: Router) -> LoginCoordinator
    func makeMainCoordinator(router: Router) -> MainCoordinator
}

final class CoordinatorFactoryImp: CoordinatorFactory {
    private let screenFactory: ScreenFactory

    init(screenFactory: ScreenFactory){
        self.screenFactory = screenFactory
    }

    func makeLoginCoordinator(router: Router) -> LoginCoordinator {
        LoginCoordinator(router: router, screenFactory: screenFactory)
    }

    func makeApplicationCoordinator(router: Router) -> ApplicationCoordinator {
        ApplicationCoordinator(router: router, coordinatorFactory: self)
    }

    func makeMainCoordinator(router: Router) -> MainCoordinator {
        MainCoordinator(router: router, screenFactory: screenFactory)
    }
}
