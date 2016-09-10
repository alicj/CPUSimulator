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
        Instruction.LoadImmediate(1, 1),
        Instruction.Add(2, 1, 1),
        Instruction.Halt
    ],
    [
        Instruction.LoadImmediate(1, 2),
        Instruction.Add(3, 1, 1),
        Instruction.Halt
    ],
    [
        Instruction.LoadImmediate(1, 5),
        Instruction.Add(4, 1, 1),
        Instruction.Halt
    ]
]
