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
        Instruction.multiply(4, 2, 3),
        Instruction.add(1, 2, 3),
        Instruction.multiply(0, 1, 3),
        Instruction.compare(2, 3),
        Instruction.branch("GT", 4),
        Instruction.add(1, 2, 3),
        Instruction.loadImmediate(1, 2),
        Instruction.multiply(1, 0, 3),
        Instruction.or(0, 0, 1),
        Instruction.store(1, 2),
        Instruction.store(2, 0),
        Instruction.load(0, 3),
        Instruction.load(1, 2),
        Instruction.not(1, 1),
        Instruction.rotate(5, 1, 3),
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
