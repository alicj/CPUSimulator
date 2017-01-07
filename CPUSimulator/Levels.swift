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
        Instruction.loadImmediate(2, 5),
        Instruction.loadImmediate(3, 2),
        Instruction.add(1, 2, 3),
        Instruction.and(0, 1, 2),
        Instruction.or(3, 0, 1),
        Instruction.multiply(1, 0, 3),
        Instruction.not(1, 1),
        Instruction.rotate(5, 1, 3),
        Instruction.halt
    ],
    [
        Instruction.loadImmediate(5, 1),
        Instruction.loadImmediate(7, 5),
        Instruction.loadImmediate(2, 4),
        Instruction.loadImmediate(1, 1),
        Instruction.loadImmediate(6, 6),
        Instruction.halt
    ],
    [
        Instruction.loadImmediate(5, 1),
        Instruction.loadImmediate(2, 5),
        Instruction.loadImmediate(7, 4),
        Instruction.loadImmediate(6, 1),
        Instruction.loadImmediate(3, 6),
        Instruction.halt
    ]
]
