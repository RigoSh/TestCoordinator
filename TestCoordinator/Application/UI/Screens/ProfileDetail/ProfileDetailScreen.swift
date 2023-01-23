//
//  ProfileDetailScreen.swift
//  TestCoordinator
//
//  Created by ishuvalov on 23.01.2023.
//  Copyright © 2023 jonfir. All rights reserved.
//

import SwiftUI

struct ProfileDetailScreen: View {
    @ObservedObject var viewModel: ProfileDetailViewModel

    var body: some View {
        VStack {
            Button(action: viewModel.onBack) {
                Text("back")
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .foregroundColor(.white)
                    .background(Color.black)
                    .cornerRadius(4)
            }
        }
    }
}
