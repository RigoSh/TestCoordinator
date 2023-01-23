//
//  InfoScreen.swift
//  ThemoviedbOne
//
//  Created by ishuvalov on 13.12.2022.
//  Copyright © 2022 jonfir. All rights reserved.
//

import SwiftUI

struct InfoScreen<ViewModel: InfoViewModel>: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        VStack {
            Text("Info")

            Button(action: viewModel.onBack) {
                Text("back")
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .foregroundColor(.white)
                    .background(Color.black)
                    .cornerRadius(4)
            }

            Button(action: viewModel.onLogout) {
                Text("logout")
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .foregroundColor(.white)
                    .background(Color.red)
                    .cornerRadius(4)
            }
        }
        .navigationTitle("info")
    }
}
