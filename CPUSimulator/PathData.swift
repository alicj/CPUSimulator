//
//  Coordinates.swift
//  CPUSimulator
//
//  Created by Alic on 2017-06-19.
//  Copyright © 2017 4ZC3. All rights reserved.
//

import Foundation
import UIKit

struct PathData {
    
    static let lineWidth: CGFloat = 5.0
    
    struct instructionBlock {
        static let toRegisterBlock: [CGPoint] = [
            CGPoint(x: 480, y: 180),
            CGPoint(x: 500, y: 210),
            CGPoint(x: 690, y: 210),
            CGPoint(x: 700, y: 220),
            CGPoint(x: 700, y: 400),
            CGPoint(x: 690, y: 410),
            CGPoint(x: 677, y: 410)
        ]
        
        static let toALUBlock: [CGPoint] = [
            CGPoint(x: 496, y: 188),
            CGPoint(x: 504, y: 200),
            CGPoint(x: 693, y: 200),
            CGPoint(x: 710, y: 216),
            CGPoint(x: 710, y: 806),
            CGPoint(x: 696, y: 820),
            CGPoint(x: 677, y: 820)
        ]
    }
    
    struct registerBlock {
        static let toALUBlock: [CGPoint] = [
            CGPoint(x: 675, y: 420),
            CGPoint(x: 690, y: 420),
            CGPoint(x: 700, y: 430),
            CGPoint(x: 700, y: 800),
            CGPoint(x: 690, y: 810),
            CGPoint(x: 677, y: 810)
        ]
        
        static let toMemoryBlock: [CGPoint] = Array(memoryBlock.toRegisterBlock.reversed())
    }
    
    struct ALUBlock {
        static let toRegisterBlock: [CGPoint] = Array(registerBlock.toALUBlock.reversed())
    }
    
    struct memoryBlock {
        static let toRegisterBlock: [CGPoint] = [
            CGPoint(x: 190, y: 100),
            CGPoint(x: 210, y: 100),
            CGPoint(x: 220, y: 110),
            CGPoint(x: 220, y: 290),
            CGPoint(x: 230, y: 300),
            CGPoint(x: 310, y: 300)
        ]
    }
    
}
