//
//  TabbarCoordinator.swift
//  TestCoordinator
//
//  Created by ishuvalov on 14.12.2022.
//  Copyright © 2022 jonfir. All rights reserved.
//

import Combine
import UIKit

protocol TabbarCoordinatorOutput: AnyObject {
    var finishFlow: VoidClosure? { get set }
}

class TabbarCoordinator: BaseCoordinator, TabbarCoordinatorOutput {
    var childCoordinators: [Coordinator]
    var finishFlow: VoidClosure?

    private let router: Router
    private let coordinatorFactory: CoordinatorFactory
    private let tabbarFactory: TabbarFactory

    private var deeplinkStep: Step?

    /// Используется для задания выбранной вкладки табБара
    private let selectTabSubject: PassthroughSubject<TabbarItem, Never>

    /// Используется для отправки действий в `ProfileCoordinator`
    private let profileCoordinatorInputAction: PassthroughSubject<ProfileCoordinatorInputAction, Never>

    init(
        router: Router,
        tabbarFactory: TabbarFactory,
        coordinatorFactory: CoordinatorFactory
    ) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
        self.tabbarFactory = tabbarFactory
        self.childCoordinators = []
        self.selectTabSubject = .init()
        self.profileCoordinatorInputAction = .init()
    }
}

extension TabbarCoordinator {
    func start(step: Step) {
        let selectedTab: TabbarItem

        switch step {
        case let appStep as AppStep:
            switch appStep {
            case .monitoringTab:
                selectedTab = .monitoring
            case .profileTab:
                selectedTab = .profile
            default:
                print("Handling unpredictable appStep: \(appStep) for \(type(of: self))")
                return
            }
        case let deeplinkStep as DeeplinkStep:
            /// табБар должен уметь обрабатывать все диплинки
            switch deeplinkStep {
            case .monitoringInfo:
                selectedTab = .monitoring
            case .profile:
                selectedTab = .profile
            case .settings:
                print("Handling unpredictable deeplinkStep: \(deeplinkStep) for \(type(of: self))")
                return
            }
            self.deeplinkStep = deeplinkStep
        default:
            print("Handling unpredictable type of step: \(step) for \(type(of: self))")
            return
        }

        let tabbarController = tabbarFactory.makeTabbarController(
            selectTabPublisher: selectTabSubject.eraseToAnyPublisher(),
            onTabSelected: tabSelectedHandler
        )

        selectTabSubject.send(selectedTab)
        router.setRootModule(tabbarController, hideBar: true)
    }
}

private extension TabbarCoordinator {
    func tabSelectedHandler(_ tab: TabbarItem, navigation: UINavigationController) {
        onTabSelected(tab: tab, navigaionController: navigation)
        /// Нужно занулить `deeplinkStep`, чтобы он отработал ровно один раз
        deeplinkStep = nil
    }

    func onTabSelected(tab: TabbarItem, navigaionController: UINavigationController) {
        print("selected tab = \(tab)")

        /// Если в навигац.стеке уже что-то есть, то это значит - не нужно туда что-то вставлять
        guard navigaionController.viewControllers.isEmpty else {
            return
        }

        switch tab {
        case .monitoring:
            runMonitoringFlow(with: deeplinkStep ?? AppStep.monitoring, in: navigaionController)
        case .profile:
            runProfileFlow(with: deeplinkStep ?? AppStep.profile, in: navigaionController)
        }
    }

    func runMonitoringFlow(with step: Step, in navigaionController: UINavigationController) {
        let router = RouterImp(rootController: navigaionController)
        let coordinator = coordinatorFactory.makeMonitoringCoordinator(router: router)
        coordinator.finishFlow = { [weak self] in
            self?.finishFlow?()
        }
        coordinator.profileHandler = { [weak self] in
            self?.selectTabSubject.send(.profile)
            self?.profileCoordinatorInputAction.send(.changeInfo)
        }
        addCoordinator(coordinator)
        coordinator.start(step: step)
    }

    func runProfileFlow(with step: Step, in navigaionController: UINavigationController) {
        let router = RouterImp(rootController: navigaionController)
        let coordinator = coordinatorFactory.makeProfileCoordinator(
            router: router,
            action: profileCoordinatorInputAction.eraseToAnyPublisher()
        )
        addCoordinator(coordinator)
        coordinator.start(step: step)
    }
}
