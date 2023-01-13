//
//  DeeplinkStepper.swift
//  TestCoordinator
//
//  Created by ishuvalov on 15.12.2022.
//  Copyright © 2022 jonfir. All rights reserved.
//

import Foundation

//protocol DeeplinkStepper {
//    var step: AppStep? { get }
//    func next() -> Self?
//}
//
//final class DeeplinkStepperImpl: DeeplinkStepper {
//    private let steps: [AppStep]
//    private var index = 0
//
//    init(steps: [AppStep]) {
//        self.steps = steps
//    }
//
//    var step: AppStep? {
//        guard index < steps.count else {
//            return nil
//        }
//        return steps[index]
//    }
//
//    func next() -> Self? {
//        index += 1
//        return self
//    }
//}
