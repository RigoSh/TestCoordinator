//
//  TabbarController.swift
//  TestCoordinator
//
//  Created by ishuvalov on 14.12.2022.
//  Copyright © 2022 jonfir. All rights reserved.
//

import UIKit

protocol TabbarController: AnyObject {
    typealias Handler = (UIViewController) -> ()

    var onViewWillAppear: Handler? { get set }
    var onMonitoringFlowSelect: Handler? { get set }
    var onProfileFlowSelect: Handler? { get set }
}

final class TabbarControllerImpl: UITabBarController, UITabBarControllerDelegate, TabbarController {
    var onViewWillAppear: Handler?
    var onMonitoringFlowSelect: Handler?
    var onProfileFlowSelect: Handler?

    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
        configureTabBar()
        setupViewControllers()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let controller = selectedViewController as? UINavigationController {
            onViewWillAppear?(controller)
        }
    }

    func tabBarController(
        _ tabBarController: UITabBarController,
        didSelect viewController: UIViewController
    ) {
        switch selectedIndex {
        case 0:
            onMonitoringFlowSelect?(viewController)
        case 1:
            onProfileFlowSelect?(viewController)
        default:
            break
        }
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
        viewControllers = [
            createNavigationController(title: "Monitoring"),
            createNavigationController(title: "Profile")
        ]
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
