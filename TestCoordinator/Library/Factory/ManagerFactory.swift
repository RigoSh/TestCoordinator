//
//  ManagerFactory.swift
//  ThemoviedbOne
//
//  Created by ishuvalov on 13.12.2022.
//  Copyright © 2022 jonfir. All rights reserved.
//

import Foundation

protocol ManagerFactory {
    func makeStorageManager() -> StorageManager
    func makeDeeplinkManager() -> DeeplinkManager
}

final class ManagerFactoryImpl: ManagerFactory {
    func makeStorageManager() -> StorageManager {
        StorageManagerImpl()
    }

    func makeDeeplinkManager() -> DeeplinkManager {
        DeeplinkManagerImpl()
    }
}
