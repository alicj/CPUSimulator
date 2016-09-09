//
//  Instructions.swift
//  CPUSimulator
//
//  Created by Alic on 2016-09-08.
//  Copyright © 2016 4ZC3. All rights reserved.
//

import Foundation

internal enum Instruction {
    case Load           (RegisterNumber, RegisterNumber, RegisterNumber)
    case Store          (RegisterNumber, RegisterNumber, RegisterNumber)
    case LoadImmediate  (RegisterNumber, RegisterValue)
    case Add            (RegisterNumber, RegisterNumber, RegisterNumber)
    case Multiply       (RegisterNumber, RegisterNumber, RegisterNumber)
    case And            (RegisterNumber, RegisterNumber, RegisterNumber)
    case Or             (RegisterNumber, RegisterNumber, RegisterNumber)
    case Not            (RegisterNumber, RegisterNumber, RegisterNumber)
    case Rotate         (RegisterNumber, RegisterNumber, Int)
    case Compare        (RegisterNumber, RegisterNumber)
    case Branch         ([Order], RegisterNumber)
    case Halt
}

internal enum Order {
    case LT, EQ, GT
}


internal typealias RegisterNumber = Int
internal typealias RegisterValue = Int
internal typealias ComparisonResult = Order
