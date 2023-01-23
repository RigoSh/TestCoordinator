//
//  MonitoringViewModel.swift
//  ThemoviedbOne
//
//  Created by ishuvalov on 13.12.2022.
//  Copyright © 2022 jonfir. All rights reserved.
//

import Combine

protocol MonitoringViewModel: ObservableObject {
    var description: String { get }
    func onLogout()
    func onInfo()
    func onProfile()
}

final class MonitoringViewModelImpl: MonitoringViewModel {
    @Published var description: String

    private let manager: StorageManager
    private let logoutHandler: VoidClosure?
    private let infoHandler: VoidClosure?
    private let profileHandler: VoidClosure?

    init(
        manager: StorageManager,
        logoutHandler: VoidClosure?,
        infoHandler: VoidClosure?,
        profileHandler: VoidClosure?
    ) {
        self.manager = manager
        self.logoutHandler = logoutHandler
        self.infoHandler = infoHandler
        self.profileHandler = profileHandler
        self.description = manager.login.map { "User with login: \($0)" } ?? "undefined user"
    }

    func onLogout() {
        logoutHandler?()
    }

    func onInfo() {
        infoHandler?()
    }

    func onProfile() {
        profileHandler?()
    }
}
