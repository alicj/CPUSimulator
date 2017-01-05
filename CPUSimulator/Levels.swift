//
//  Levels.swift
//  CPUSimulator
//
//  Created by Alic on 2016-09-10.
//  Copyright © 2016 4ZC3. All rights reserved.
//

import Foundation

let LEVELS = [
    [
        Instruction.LoadImmediate(2, 5),
        Instruction.LoadImmediate(3, 2),
        Instruction.Add(1, 2, 3),
        Instruction.And(0, 1, 2),
        Instruction.Or(3, 0, 1),
        Instruction.Multiply(1, 0, 3),
        Instruction.Not(1, 1),
        Instruction.Rotate(5, 1, 3),
        Instruction.Halt
    ],
    [
        Instruction.LoadImmediate(5, 1),
        Instruction.LoadImmediate(7, 5),
        Instruction.LoadImmediate(2, 4),
        Instruction.LoadImmediate(1, 1),
        Instruction.LoadImmediate(6, 6),
        Instruction.Halt
    ],
    [
        Instruction.LoadImmediate(5, 1),
        Instruction.LoadImmediate(2, 5),
        Instruction.LoadImmediate(7, 4),
        Instruction.LoadImmediate(6, 1),
        Instruction.LoadImmediate(3, 6),
        Instruction.Halt
    ]
]
