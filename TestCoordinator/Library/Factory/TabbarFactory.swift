//
//  TabbarFactory.swift
//  TestCoordinator
//
//  Created by ishuvalov on 14.12.2022.
//  Copyright © 2022 jonfir. All rights reserved.
//

import Combine
import UIKit

protocol TabbarFactory {
    func makeTabbarController(
        selectTabPublisher: AnyPublisher<TabbarItem, Never>,
        onTabSelected: @escaping (TabbarItem, UINavigationController) -> Void
    ) -> Presentable
}

final class TabbarFactoryImpl: TabbarFactory {
    func makeTabbarController(
        selectTabPublisher: AnyPublisher<TabbarItem, Never>,
        onTabSelected: @escaping TabbarControllerImpl.Handler
    ) -> Presentable {
        TabbarControllerImpl(
            selectTabSubject: selectTabPublisher,
            onTabSelected: onTabSelected
        )
    }
}
