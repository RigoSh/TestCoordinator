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

            Button(action: viewModel.onBack) {
                Text("back")
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .foregroundColor(.white)
                    .background(Color.red)
                    .cornerRadius(4)
            }

            Button(action: viewModel.onInfo) {
                Text("show info")
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
