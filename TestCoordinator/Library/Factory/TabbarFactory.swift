//
//  TabbarFactory.swift
//  TestCoordinator
//
//  Created by ishuvalov on 14.12.2022.
//  Copyright © 2022 jonfir. All rights reserved.
//

import UIKit

protocol TabbarFactory {
    func makeTabbarController() -> TabbarController & Presentable
}

final class TabbarFactoryImpl: TabbarFactory {
    func makeTabbarController() -> TabbarController & Presentable {
        TabbarControllerImpl()
    }
}
