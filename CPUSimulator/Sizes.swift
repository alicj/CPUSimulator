//
//  Sizes.swift
//  CPUSimulator
//
//  Created by Alic on 2017-02-09.
//  Copyright © 2017 4ZC3. All rights reserved.
//

import Foundation
import UIKit

struct Sizes {
    
    static let debugColor = UIColor(red: 0xFA, green: 0xFA, blue: 0xFA)
    static let margin = 8.0
    
    struct font {
        static let large = CGFloat(23)
        static let medium = CGFloat(18)
        static let small = CGFloat(16)
    }
    
    struct hintMessage {
        static let x = registerBlock.x
        static let y = registerBlock.y + registerBlock.height * 0.75
        static let width = registerBlock.width * 0.75
        static let height = 44.0
        static let frame = CGRect(x: x, y: y, width: width, height: height)
        static let font = Sizes.font.medium
    }
    
    struct register {
        static let width = label.width
        static let height = width
        static let frame = CGRect(origin: CGPoint.zero, size: CGSize(width: width, height: height))
        
        struct label {
            static let width = 120.0
            static let height = 24.0
            static let font = Sizes.font.small
            static let frame = CGRect(origin: CGPoint.zero, size: CGSize(width: width, height: height))
        }
        
        struct value {
            static let x = 0.0
            static let y = label.height
            static let width = label.width
            static let height = width - label.height
            static let font = Sizes.font.large
            static let frame = CGRect(origin: CGPoint(x: x, y: y), size: CGSize(width: width, height: height))
        }
    }
    
    struct operand {
        static let width = height
        static let height = register.height
        static let font = Sizes.font.large
        static let frame = CGRect(origin: CGPoint.zero, size: CGSize(width: width, height: height))
    }
    
    struct draggable {
        static let width = height
        static let height = operand.height
        static let font = Sizes.font.large
        static let color = UIColor.red
        
        static let offsetForRegister = CGPoint(
            x: (Sizes.register.width - Sizes.draggable.width) / 2,
            y: (Sizes.register.height - Sizes.draggable.height) / 2 + Sizes.register.label.height / 2
        )
        static let offsetForMemory = CGPoint(x: memoryBlock.cell
            .width * 0.75 - width * 0.5, y: (memoryBlock.cell.height - height) / 2)
        
        static let originForInstruction = CGPoint(x: 695 - width / 2, y: 108.5 - height / 2)
        static let originForOperator = CGPoint(x: CGFloat(ALUBlock.x) + ALUBlock.originForOperator.x - CGFloat(width + margin * 2), y: CGFloat(ALUBlock.y) + ALUBlock.originForOperator.y)

        static let size = CGSize(width: width, height: height)
        static let frame = CGRect(origin: CGPoint.zero, size: size)
    }

    struct registerBlock {
        static let x = 245.0
        static let y = instructionBlock.y + instructionBlock.height + 2 * margin
        static let width = 4 * register.width + 3 * margin
        static let height = 3 * register.width + 2 * margin
        
        static let frame = CGRect(x: x, y: y, width: width, height: height)
    }
    
    struct ALUBlock {
        static let originForRightOperand = CGPoint(x: 1.5 * operand.width, y: 0)
        static let originForOperator = CGPoint(x: 0.75 * operand.width, y: operand.width + margin * 2)
        static let originForResult = CGPoint(x: 0.75 * operand.width, y: (operand.height + margin * 2 ) * 2)
        
        static let x = registerBlock.x + (registerBlock.width - width) / 2
        static let y = registerBlock.y + registerBlock.height + margin * 2
        static let width = Double(originForRightOperand.x) + operand.width
        static let height = Double(originForResult.y) + operand.height
        
        static let frame = CGRect(x: x, y: y, width: width, height: height)
        

    }
    
    struct instructionBlock {
        static let x = 250.0
        static let y = 28.0
        static let width = 500.0
        static let height = 150.0
        static let font = Sizes.font.medium
        
        static let frame = CGRect(x: x, y: y, width: width, height: height)
    }
    
    struct memoryBlock {
        
        struct cell {
            static let height = 44.0
            static let width = memoryBlock.width
            
            static let frameForLeftColumn = CGRect(x: 0, y: 0, width: width/2, height: height)
            static let frameForRightColumn = CGRect(x: width/2, y: 0, width: width/2, height: height)
            static let frame = CGRect(x: 0, y: 0, width: width, height: height)
        }
        
        static let x = 28.8
        static let y = 28.0
        static let width = 180.0
        static let height = 975.0
        static let font = Sizes.font.medium
        
        static let frame = CGRect(x: x, y: y, width: width, height: height)
    }
}
