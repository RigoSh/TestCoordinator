//
//  LoginViewModel.swift
//  ThemoviedbOne
//
//  Created by ishuvalov on 13.12.2022.
//  Copyright © 2022 jonfir. All rights reserved.
//

import Combine

protocol LoginViewModel: ObservableObject {
    var loginText: String { get set }
    func onLogin()
}

final class LoginViewModelImpl: LoginViewModel {
    @Published var loginText: String

    private var manager: StorageManager
    private let loginHandler: VoidClosure?

    init(manager: StorageManager, loginHandler: VoidClosure?) {
        self.manager = manager
        self.loginHandler = loginHandler
        self.loginText = manager.login ?? ""
    }

    func onLogin() {
        manager.login = loginText
        loginHandler?()
    }
}
