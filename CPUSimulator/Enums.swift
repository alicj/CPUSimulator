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
    case branch         ([Order], RegisterNumber)
    case halt
}

internal enum Order {
    case lt, eq, gt
}

internal enum State {
    // universal
    case null
    case gameStart
    // not used
    case successDrag
    case waitForDrag
    // loadimmediate
    case waitForDragRegister
    case successDragRegister
    // add, multiply, and, or, not
    case waitForDragCalc
    case successDragCalc
    case waitForDragOperand1
    case waitForDragOperand2
    case waitForDragOperator
    case waitForDragResult
}


internal typealias RegisterNumber = Int
internal typealias RegisterValue = Int
internal typealias ComparisonResult = Order


