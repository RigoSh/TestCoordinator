//
//  LoginScreen.swift
//  ThemoviedbOne
//
//  Created by ishuvalov on 13.12.2022.
//  Copyright © 2022 jonfir. All rights reserved.
//

import SwiftUI

struct LoginScreen<ViewModel: LoginViewModel>: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        VStack(spacing: 20) {
            TextField("", text: $viewModel.loginText)
                .background(Color.gray.cornerRadius(3))

            Button(action: viewModel.onLogin) {
                Text("login")
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(4)
            }
        }
        .padding(.horizontal, 20)
    }
}

struct FFF {
    func fffd() -> some View {
        let vm = LoginViewModelImpl(manager: StorageManagerImpl(), loginHandler: nil)
        return LoginScreen(viewModel: vm)
    }
}

//extension LoginScreen {
//    static func make() -> some View {
//        let vm = LoginViewModelImpl(manager: StorageManagerImpl(), loginHandler: nil)
//        return LoginScreen(viewModel: vm)
//    }
//}
