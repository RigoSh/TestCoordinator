//
//  Step.swift
//  TestCoordinator
//
//  Created by ishuvalov on 16.12.2022.
//  Copyright © 2022 jonfir. All rights reserved.
//

import Foundation

protocol Step {}

enum AppStep: Step {
    case auth

    case main

    case monitoringTab
    case profileTab

    case monitoring
    case monitoringInfo

    case profile
}

enum DeeplinkStep: Step {
    case monitoringInfo
    case profile
    case settings
}
