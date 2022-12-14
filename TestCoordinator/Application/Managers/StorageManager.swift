//
//  StorageManager.swift
//  ThemoviedbOne
//
//  Created by ishuvalov on 13.12.2022.
//  Copyright © 2022 jonfir. All rights reserved.
//

import Foundation

protocol StorageManager {
    var login: String? { get set }
}

final class StorageManagerImpl: StorageManager {
    var login: String? {
        get {
            UserDefaults.standard.string(forKey: StorageManagerKey.login.rawValue)
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: StorageManagerKey.login.rawValue)
        }
    }
}

private extension StorageManagerImpl {
    enum StorageManagerKey: String {
        case login
    }
}
