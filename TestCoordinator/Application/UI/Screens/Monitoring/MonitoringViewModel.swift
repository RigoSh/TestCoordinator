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
    func onBack()
    func onInfo()
    func onProfile()
}

final class MonitoringViewModelImpl: MonitoringViewModel {
    @Published var description: String

    private let manager: StorageManager
    private let backHandler: VoidClosure?
    private let infoHandler: VoidClosure?
    private let profileHandler: VoidClosure?

    init(
        manager: StorageManager,
        backHandler: VoidClosure?,
        infoHandler: VoidClosure?,
        profileHandler: VoidClosure?
    ) {
        self.manager = manager
        self.backHandler = backHandler
        self.infoHandler = infoHandler
        self.profileHandler = profileHandler
        self.description = manager.login.map { "User with login: \($0)" } ?? "undefined user"
    }

    func onBack() {
        backHandler?()
    }

    func onInfo() {
        infoHandler?()
    }

    func onProfile() {
        profileHandler?()
    }
}
