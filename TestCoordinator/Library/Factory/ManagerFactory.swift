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
}

final class ManagerFactoryImpl: ManagerFactory {
    func makeStorageManager() -> StorageManager {
        StorageManagerImpl()
    }
}
