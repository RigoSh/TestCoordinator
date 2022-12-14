//
//  ScreenFactory.swift
//  ThemoviedbOne
//
//  Created by ishuvalov on 13.12.2022.
//  Copyright © 2022 jonfir. All rights reserved.
//

import SwiftUI
import UIKit

protocol ScreenFactory {
    func makeLoginScreen(loginHandler: VoidClosure?) -> UIViewController
    func makeMainScreen(backHandler: VoidClosure?, infoHandler: VoidClosure?) -> UIViewController
    func makeInfoScreen(backHandler: VoidClosure?, logoutHandler: VoidClosure?) -> UIViewController
}

final class ScreenFactoryImpl: ScreenFactory {
    weak var container: Container!

    func makeLoginScreen(loginHandler: VoidClosure?) -> UIViewController {
        let manager = container.managerFactory.makeStorageManager()
        let vm = LoginViewModelImpl(manager: manager, loginHandler: loginHandler)
        let vc = UIHostingController(rootView: LoginScreen(viewModel: vm))
        return vc
    }

    func makeMainScreen(backHandler: VoidClosure?, infoHandler: VoidClosure?) -> UIViewController {
        let manager = container.managerFactory.makeStorageManager()
        let vm = MainViewModelImpl(manager: manager, backHandler: backHandler, infoHandler: infoHandler)
        let vc = UIHostingController(rootView: MainScreen(viewModel: vm))
        return vc
    }

    func makeInfoScreen(backHandler: VoidClosure?, logoutHandler: VoidClosure?) -> UIViewController {
        let vm = InfoViewModelImpl(backHandler: backHandler, logoutHandler: logoutHandler)
        let vc = UIHostingController(rootView: InfoScreen(viewModel: vm))
        return vc
    }
}
