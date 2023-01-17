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
    func makeLoginScreen(hideBar: Bool, loginHandler: VoidClosure?) -> UIViewController

    func makeMonitoringScreen(
        hideBar: Bool,
        backHandler: VoidClosure?,
        infoHandler: VoidClosure?,
        profileHandler: VoidClosure?
    ) -> UIViewController

    func makeInfoScreen(
        hideBar: Bool,
        backHandler: VoidClosure?,
        logoutHandler: VoidClosure?
    ) -> UIViewController

    func makeProfileScreen(hideBar: Bool) -> UIViewController
}

final class ScreenFactoryImpl: ScreenFactory {
    weak var container: Container!

    func makeLoginScreen(hideBar: Bool, loginHandler: VoidClosure?) -> UIViewController {
        let manager = container.managerFactory.makeStorageManager()
        let vm = LoginViewModelImpl(manager: manager, loginHandler: loginHandler)
        let vc = CustomHostingController(hideBar: hideBar, content: LoginScreen(viewModel: vm))
        return vc
    }

    func makeMonitoringScreen(
        hideBar: Bool,
        backHandler: VoidClosure?,
        infoHandler: VoidClosure?,
        profileHandler: VoidClosure?
    ) -> UIViewController {
        let manager = container.managerFactory.makeStorageManager()
        let vm = MonitoringViewModelImpl(
            manager: manager,
            backHandler: backHandler,
            infoHandler: infoHandler,
            profileHandler: profileHandler
        )
        let vc = CustomHostingController(hideBar: hideBar, content: MonitoringScreen(viewModel: vm))
        return vc
    }

    func makeInfoScreen(
        hideBar: Bool,
        backHandler: VoidClosure?,
        logoutHandler: VoidClosure?
    ) -> UIViewController {
        let vm = InfoViewModelImpl(backHandler: backHandler, logoutHandler: logoutHandler)
        let vc = CustomHostingController(hideBar: hideBar, content: InfoScreen(viewModel: vm))
        return vc
    }

    func makeProfileScreen(hideBar: Bool) -> UIViewController {
        let vm = ProfileViewModelImpl()
        let vc = CustomHostingController(hideBar: hideBar, content: ProfileScreen(viewModel: vm))
        return vc
    }
}

private class CustomHostingController<Content: View>: UIHostingController<AnyView> {
    init(hideBar: Bool, content: Content) {
        super.init(rootView: AnyView(content.navigationBarHidden(hideBar)))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
