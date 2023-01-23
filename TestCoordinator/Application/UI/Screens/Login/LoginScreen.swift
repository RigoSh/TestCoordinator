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
            HStack {
                Text("login name")

                TextField("", text: $viewModel.loginText)
                    .textFieldStyle(.roundedBorder)
                    .foregroundColor(.blue)
            }

            Button(action: viewModel.onLogin) {
                Text("auth")
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
