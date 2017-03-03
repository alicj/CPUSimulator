//
//  Instructions.swift
//  CPUSimulator
//
//  Created by Alic on 2016-09-08.
//  Copyright © 2016 4ZC3. All rights reserved.
//

import Foundation

internal enum Instruction {
    case load           (RegisterNumber, RegisterNumber) // simplified
    case store          (RegisterNumber, RegisterNumber) // simplified
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
    case successDragCalcResult
    // branch
    case successBranch
    // store and load
    case waitForLoad
    case waitForStore
    case successLoad
    case successStore
}


internal typealias RegisterNumber = Int
internal typealias RegisterValue = Int
internal typealias Condition = String


