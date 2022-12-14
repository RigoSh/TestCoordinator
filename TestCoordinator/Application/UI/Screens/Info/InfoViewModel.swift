//
//  InfoViewModel.swift
//  ThemoviedbOne
//
//  Created by ishuvalov on 13.12.2022.
//  Copyright © 2022 jonfir. All rights reserved.
//

import Combine

protocol InfoViewModel: ObservableObject {
    func onBack()
    func onLogout()
}

final class InfoViewModelImpl: InfoViewModel {
    private let backHandler: VoidClosure?
    private let logoutHandler: VoidClosure?

    init(backHandler: VoidClosure?, logoutHandler: VoidClosure?) {
        self.backHandler = backHandler
        self.logoutHandler = logoutHandler
    }

    func onBack() {
        backHandler?()
    }

    func onLogout() {
        logoutHandler?()
    }
}
