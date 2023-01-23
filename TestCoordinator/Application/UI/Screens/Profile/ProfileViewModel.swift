//
//  ProfileViewModel.swift
//  TestCoordinator
//
//  Created by ishuvalov on 14.12.2022.
//  Copyright © 2022 jonfir. All rights reserved.
//

import Combine

protocol ProfileViewModel: ObservableObject {
    func onDetail()
}

final class ProfileViewModelImpl: ProfileViewModel {
    private let detailHandler: VoidClosure?

    init(detailHandler: VoidClosure?) {
        self.detailHandler = detailHandler
    }

    func onDetail() {
        detailHandler?()
    }
}
