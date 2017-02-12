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
    static let margin = 8
    
    struct font {
        static let large = CGFloat(24)
        static let medium = CGFloat(18)
        static let small = CGFloat(14)
    }
    
    struct register {
        
        static let x = 0
        static let y = 0
        static let width = label.width
        static let height = label.height + value.height
        static let frame = CGRect(x: x, y: y, width: width, height: height)
        
        struct label {
            static let x = 0
            static let y = 0
            static let width = 120
            static let height = 24
            static let font = Sizes.font.medium
            
            static let frame = CGRect(x: x, y: y, width: width, height: height)
        }
        
        struct value {
            static let x = 0
            static let y = label.height
            static let width = label.width
            static let height = label.width - label.height
            static let font = Sizes.font.large
            
            static let frame = CGRect(x: x, y: y, width: width, height: height)
        }
    }
    struct operand {
        static let x = 0
        static let y = 0
        static let width = height
        static let height = register.value.height
        static let font = Sizes.font.medium
        
        static let frame = CGRect(x: x, y: y, width: width, height: height)
    }
    
    struct registerBlock {
        static let x = 200
        static let y = 186
        static let width = 4 * register.width + 3 * margin
        static let height = 3 * register.width + 2 * margin
        
        static let frame = CGRect(x: x, y: y, width: width, height: height)
    }
    
    struct ALUBlock {
        static let x = 0
        static let y = 0
        static let width = 1
        static let height = 1
        
        static let frame = CGRect(x: x, y: y, width: width, height: height)
        
//        static let leftOperandFrame = CGRect(x: 0, y: 0, width: operand.width, height: operand.height)
//        
//        static let rightOperandFrame = CGRect(x: operand.width + margin, y: 0, width: operand.width, height: operand.height)
//        
//        static let operatorFrame = CGRect(x: 0, y: operand.width + margin, width: operand.width, height: operand.height)
//        
//        static let resultFrame = CGRect(x: Int(0.5 * Double(operand.width)), y: (operand.height + margin) * 2, width: operand.width, height: operand.height)
    }
    
    struct instructionBlock {
        static let x = 200
        static let y = 28
        static let width = 550
        static let height = 150
        static let font = Sizes.font.medium
        
        static let frame = CGRect(x: x, y: y, width: width, height: height)
    }
}
