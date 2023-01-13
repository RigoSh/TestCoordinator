//
//  TabbarController.swift
//  TestCoordinator
//
//  Created by ishuvalov on 14.12.2022.
//  Copyright © 2022 jonfir. All rights reserved.
//

import Combine
import UIKit

enum TabbarItem: Int, CaseIterable {
    case monitoring = 0
    case profile = 1

    var title: String {
        switch self {
        case .monitoring:
            return "Мониторинг замеров"
        case .profile:
            return "Профиль"
        }
    }
}

final class TabbarControllerImpl: UITabBarController {
    typealias Handler = (TabbarItem, UINavigationController) -> Void

    private let selectTabSubject: AnyPublisher<TabbarItem, Never>
    private let onTabSelected: Handler
    private var cancelBag = Set<AnyCancellable>()

    init(selectTabSubject: AnyPublisher<TabbarItem, Never>, onTabSelected: @escaping Handler) {
        self.selectTabSubject = selectTabSubject
        self.onTabSelected = onTabSelected

        super.init(nibName: nil, bundle: nil)
        makeSubscriptions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
        configureTabBar()
        setupViewControllers()
    }
}

extension TabbarControllerImpl: UITabBarControllerDelegate {
    func tabBarController(
        _ tabBarController: UITabBarController,
        didSelect viewController: UIViewController
    ) {
        onViewContollerSelected(with: viewController)
    }
}

private extension TabbarControllerImpl {
    func configureTabBar() {
        tabBar.barTintColor = .white
        tabBar.backgroundColor = .white
        tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = .gray
    }

    func setupViewControllers() {
        viewControllers = TabbarItem
            .allCases
            .map(\.title)
            .map(createNavigationController)
    }

    func makeSubscriptions() {
        selectTabSubject
            .sink(receiveValue: onSelectTab)
            .store(in: &cancelBag)
    }

    func onSelectTab(_ tab: TabbarItem) {
        selectedIndex = tab.rawValue
        if let viewController = selectedViewController {
            onViewContollerSelected(with: viewController)
        }
    }

    func onViewContollerSelected(with viewController: UIViewController) {
        guard
            let tab = TabbarItem(rawValue: selectedIndex),
            let navigation = viewController as? UINavigationController
        else {
            return
        }

        onTabSelected(tab, navigation)
    }

    func createNavigationController(title: String) -> UINavigationController {
        let navController = UINavigationController()
        navController.tabBarItem.title = title
        //        navController.tabBarItem.image = image
        //        navController.navigationBar.prefersLargeTitles = false
        //        rootViewController.navigationItem.title = title
        return navController
    }
}
