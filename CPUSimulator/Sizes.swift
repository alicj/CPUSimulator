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
    static let margin = 5.0
    static let padding = 10.0
    static let screenWidth = Double(UIScreen.main.bounds.width)
    static let screenHeight = Double(UIScreen.main.bounds.height)
    static let screenPadding = 28.0
    static let verticlePaddingBtwBlocks = (screenHeight - screenPadding * 2 - instructionBlock.height - registerBlock.height - ALUBlock.height)/2

    
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
        static let frame = CGRect(origin: CGPoint(x: padding, y: padding), size: CGSize(width: width, height: height))
        
        struct label {
            static let width = 115.0
            static let height = 26.0
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
        static let height = register.height - 5.0
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
        static let x = instructionBlock.x + (instructionBlock.width - width) / 2
        static let y = instructionBlock.y + instructionBlock.height +  verticlePaddingBtwBlocks
        static let width = 3 * register.width + 2 * margin + 2 * padding
        static let height = 3 * register.width + 2 * margin + 2 * padding

        static let frame = CGRect(x: x, y: y, width: width, height: height)
    }
    
    struct ALUBlock {
        static let x = registerBlock.x + (registerBlock.width - ALUBlock.width)
        static let y = registerBlock.y + registerBlock.height + verticlePaddingBtwBlocks
        static let width = 2 * operand.width + margin + 2 * padding
        static let height = 3 * operand.width + 2 * margin + 2 * padding
        
        static let originForFirstOperand = CGPoint(x: padding + operand.width + margin, y: padding)
        static let originForSecondOperand = CGPoint(x: padding + operand.width + margin, y: padding + operand.width + margin)

        static let originForOperator = CGPoint(x: padding, y: padding + operand.width + margin)
        static let originForResult = CGPoint(x: padding + operand.width + margin, y: padding + 2 * (operand.width + margin))

        static let frame = CGRect(x: x, y: y, width: width, height: height)
        

    }
    
    struct instructionBlock {
        static let x = 240.0
        static let y = 28.0
        static let width = 500.0
        static let height = 162.0
        static let rowHeight: CGFloat = 36.0
        static let font = Sizes.font.medium
        
        static let frame = CGRect(x: x, y: y, width: width, height: height)
    }
    
    struct memoryBlock {
        
        struct cell {
            static let height = 44.0
            static let width = memoryBlock.width
            
            static let frameForLeftColumn = CGRect(x: 0, y: 0, width: width/2 + 5, height: height)
            static let frameForRightColumn = CGRect(x: width/2, y: 0, width: width/2 - 5, height: height)
            static let frame = CGRect(x: 0, y: 0, width: width, height: height)
        }
        
        static let x = 28.0
        static let y = 28.0
        static let width = 165.0
        static let height = 968.0
        static let font = Sizes.font.medium
        
        static let frame = CGRect(x: x, y: y, width: width, height: height)
    }
}
