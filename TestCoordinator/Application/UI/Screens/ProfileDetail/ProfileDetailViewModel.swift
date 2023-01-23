//
//  ProfileDetailViewModel.swift
//  TestCoordinator
//
//  Created by ishuvalov on 23.01.2023.
//  Copyright © 2023 jonfir. All rights reserved.
//

import Combine

final class ProfileDetailViewModel: ObservableObject {
    private let backHandler: VoidClosure?

    init(backHandler: VoidClosure?) {
        self.backHandler = backHandler
    }

    func onBack() {
        backHandler?()
    }
}
