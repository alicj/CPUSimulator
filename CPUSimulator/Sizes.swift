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
    
    static let debugColor = UIColor(red: 0xEE, green: 0xEE, blue: 0xEE)
    static let margin = 8.0
    
    struct font {
        static let large = CGFloat(23)
        static let medium = CGFloat(18)
        static let small = CGFloat(16)
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
        static let height = register.value.height
        static let font = Sizes.font.large
        static let frame = CGRect(origin: CGPoint.zero, size: CGSize(width: width, height: height))
    }
    
    struct draggable {
        static let width = height
        static let height = operand.height
        static let font = Sizes.font.large
        
        static let offsetForRegister = CGPoint(
            x: (Sizes.register.value.width - Sizes.draggable.width) / 2,
            y: (Sizes.register.value.height - Sizes.draggable.height) / 2 + Sizes.register.label.height
        )
        
        static let originForInstruction = CGPoint(x: 695 - width / 2, y: 103.5 - height / 2)
        static let originForOperator = CGPoint(x: ALUBlock.x, y: ALUBlock.y + ALUBlock.height)
        static let size = CGSize(width: width, height: height)
        static let frame = CGRect(origin: CGPoint.zero, size: size)
    }

    struct registerBlock {
        static let x = 245.0
        static let y = 186.0
        static let width = 4 * register.width + 3 * margin
        static let height = 3 * register.width + 2 * margin
        
        static let frame = CGRect(x: x, y: y, width: width, height: height)
    }
    
    struct ALUBlock {
        static let originForRightOperand = CGPoint(x: 1.5 * operand.width, y: 0)
        static let originForOperator = CGPoint(x: 0.75 * operand.width, y: operand.width + margin * 2)
        static let originForResult = CGPoint(x: 0.75 * operand.width, y: (operand.height + margin * 2 ) * 2)
        
        static let x = registerBlock.x + (registerBlock.width - width) / 2
        static let y = registerBlock.y + registerBlock.height + margin
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
        static let height = 996.0
        static let font = Sizes.font.medium
        
        static let frame = CGRect(x: x, y: y, width: width, height: height)
    }
}
