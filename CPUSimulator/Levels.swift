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
        Instruction.Add(1, 2, 3),
        Instruction.LoadImmediate(3, 4),
        Instruction.LoadImmediate(4, 1),
        Instruction.LoadImmediate(5, 6),
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
