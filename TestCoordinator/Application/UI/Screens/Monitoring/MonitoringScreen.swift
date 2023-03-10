//
//  MonitoringScreen.swift
//  ThemoviedbOne
//
//  Created by ishuvalov on 13.12.2022.
//  Copyright © 2022 jonfir. All rights reserved.
//

import SwiftUI

struct MonitoringScreen<ViewModel: MonitoringViewModel>: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        VStack(spacing: 20) {
            Text(viewModel.description)

            Button(action: viewModel.onInfo) {
                Text("show info")
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(4)
            }

            Button(action: viewModel.onProfile) {
                Text("to profile detail")
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .foregroundColor(.white)
                    .background(Color.green)
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
        .navigationTitle("Monitoring")
        .padding(.horizontal, 20)
    }
}
