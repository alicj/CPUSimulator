//
//  Instructions.swift
//  CPUSimulator
//
//  Created by Alic on 2016-09-08.
//  Copyright © 2016 4ZC3. All rights reserved.
//

import Foundation

internal enum Instruction {
    case load           (RegisterNumber, RegisterNumber, RegisterNumber)
    case store          (RegisterNumber, RegisterNumber, RegisterNumber)
    case loadImmediate  (RegisterNumber, RegisterValue)
    case add            (RegisterNumber, RegisterNumber, RegisterNumber)
    case multiply       (RegisterNumber, RegisterNumber, RegisterNumber)
    case and            (RegisterNumber, RegisterNumber, RegisterNumber)
    case or             (RegisterNumber, RegisterNumber, RegisterNumber)
    case not            (RegisterNumber, RegisterNumber)
    case rotate         (RegisterNumber, RegisterNumber, Int)
    case compare        (RegisterNumber, RegisterNumber)
    case branch         (Condition, RegisterNumber)
    case halt
}

internal enum State {
    // universal
    case null
    case gameStart
    // loadimmediate
    case waitForLoadImmediate
    case successLoadImmediate
    // add, multiply, and, or, not, compare
    case waitForDragOperands
    case successDragOperands
    case waitForDragCalcResult
    //branch
    case successBranch
}


internal typealias RegisterNumber = Int
internal typealias RegisterValue = Int
internal typealias Condition = String


