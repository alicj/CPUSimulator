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
    
    static let debugColor = UIColor(red: 0xEE, green: 0xEE, blue: 0xEE).cgColor
    static let margin = 8.0
    
    struct font {
        static let large = CGFloat(24)
        static let medium = CGFloat(18)
        static let small = CGFloat(14)
    }
    
    struct register {
        static let width = label.width
        static let height = width
        static let frame = CGRect(origin: CGPoint.zero, size: CGSize(width: width, height: height))
        
        struct label {
            static let width = 120.0
            static let height = 24.0
            static let font = Sizes.font.medium
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
        
        static let instruction_origin = CGPoint(x: 670.5 - Double(width / 2), y: 103.5 - Double(height / 2))
        static let operator_origin = CGPoint(x: ALUBlock.x, y: ALUBlock.y + ALUBlock.height)
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
        static let rightOperandOrigin = CGPoint(x: 1.5 * operand.width, y: 0)
        static let operatorOrigin = CGPoint(x: 0.75 * operand.width, y: operand.width + margin)
        static let resultOrigin = CGPoint(x: 0.75 * operand.width, y: (operand.height + margin) * 2)
        
        static let x = registerBlock.x + (registerBlock.width - width) / 2
        static let y = registerBlock.y + registerBlock.height + margin
        static let width = Double(rightOperandOrigin.x) + operand.width
        static let height = Double(resultOrigin.y) + operand.height
        
        static let frame = CGRect(x: x, y: y, width: width, height: height)
        

    }
    
    struct instructionBlock {
        static let x = 200.0
        static let y = 28.0
        static let width = 550.0
        static let height = 150.0
        static let font = Sizes.font.medium
        
        static let frame = CGRect(x: x, y: y, width: width, height: height)
    }
}
