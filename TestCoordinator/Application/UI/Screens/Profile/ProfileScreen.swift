//
//  ProfileScreen.swift
//  TestCoordinator
//
//  Created by ishuvalov on 14.12.2022.
//  Copyright © 2022 jonfir. All rights reserved.
//

import SwiftUI

struct ProfileScreen<ViewModel: ProfileViewModel>: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        VStack(spacing: 20) {
            Text("Profile info")

            Button(action: viewModel.onDetail) {
                Text("detail")
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
