//
//  MainViewModel.swift
//  ThemoviedbOne
//
//  Created by ishuvalov on 13.12.2022.
//  Copyright © 2022 jonfir. All rights reserved.
//

import Combine

protocol MainViewModel: ObservableObject {
    var description: String { get }
    func onBack()
    func onInfo()
}

final class MainViewModelImpl: MainViewModel {
    @Published var description: String

    private let manager: StorageManager
    private let backHandler: VoidClosure?
    private let infoHandler: VoidClosure?

    init(
        manager: StorageManager,
        backHandler: VoidClosure?,
        infoHandler: VoidClosure?
    ) {
        self.manager = manager
        self.backHandler = backHandler
        self.infoHandler = infoHandler
        self.description = manager.login.map { "User with login: \($0)" } ?? "undefined user"
    }

    func onBack() {
        backHandler?()
    }

    func onInfo() {
        infoHandler?()
    }
}