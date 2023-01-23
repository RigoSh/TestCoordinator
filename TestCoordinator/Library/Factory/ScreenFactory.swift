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
    func makeLoginScreen(hideNavBar: Bool, loginHandler: VoidClosure?) -> UIViewController

    func makeMonitoringScreen(
        hideNavBar: Bool,
        logoutHandler: VoidClosure?,
        infoHandler: VoidClosure?,
        profileHandler: VoidClosure?
    ) -> UIViewController

    func makeInfoScreen(
        hideNavBar: Bool,
        backHandler: VoidClosure?,
        logoutHandler: VoidClosure?
    ) -> UIViewController

    func makeProfileScreen(
        hideNavBar: Bool,
        detailHandler: VoidClosure?
    ) -> UIViewController

    func makeProfileDetailScreen(
        hideNavBar: Bool,
        backHandler: VoidClosure?
    ) -> UIViewController
}

final class ScreenFactoryImpl: ScreenFactory {
    weak var container: Container!

    func makeLoginScreen(hideNavBar: Bool, loginHandler: VoidClosure?) -> UIViewController {
        let manager = container.managerFactory.makeStorageManager()
        let vm = LoginViewModelImpl(manager: manager, loginHandler: loginHandler)
        let vc = CustomHostingController(hideNavBar: hideNavBar, content: LoginScreen(viewModel: vm))
        return vc
    }

    func makeMonitoringScreen(
        hideNavBar: Bool,
        logoutHandler: VoidClosure?,
        infoHandler: VoidClosure?,
        profileHandler: VoidClosure?
    ) -> UIViewController {
        let manager = container.managerFactory.makeStorageManager()
        let vm = MonitoringViewModelImpl(
            manager: manager,
            logoutHandler: logoutHandler,
            infoHandler: infoHandler,
            profileHandler: profileHandler
        )
        let vc = CustomHostingController(hideNavBar: hideNavBar, content: MonitoringScreen(viewModel: vm))
        return vc
    }

    func makeInfoScreen(
        hideNavBar: Bool,
        backHandler: VoidClosure?,
        logoutHandler: VoidClosure?
    ) -> UIViewController {
        let vm = InfoViewModelImpl(backHandler: backHandler, logoutHandler: logoutHandler)
        let vc = CustomHostingController(hideNavBar: hideNavBar, content: InfoScreen(viewModel: vm))
        return vc
    }

    func makeProfileScreen(
        hideNavBar: Bool,
        detailHandler: VoidClosure?
    ) -> UIViewController {
        let vm = ProfileViewModelImpl(detailHandler: detailHandler)
        let vc = CustomHostingController(hideNavBar: hideNavBar, content: ProfileScreen(viewModel: vm))
        return vc
    }

    func makeProfileDetailScreen(
        hideNavBar: Bool,
        backHandler: VoidClosure?
    ) -> UIViewController {
        let vm = ProfileDetailViewModel(backHandler: backHandler)
        let vc = CustomHostingController(hideNavBar: hideNavBar, content: ProfileDetailScreen(viewModel: vm))
        return vc
    }
}

private class CustomHostingController<Content: View>: UIHostingController<AnyView> {
    init(hideNavBar: Bool, content: Content) {
        super.init(rootView: AnyView(content.navigationBarHidden(hideNavBar)))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
