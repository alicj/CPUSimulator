//
//  Binary.swift
//  CPUSimulator
//
//  Created by Alic on 2017-06-29.
//  Copyright © 2017 4ZC3. All rights reserved.
//  http://sketchytech.blogspot.ca/2015/11/bytes-for-beginners-representation-of.html

import Foundation


class BinaryUtils {
    static func toBinary(num:Int8) -> String {
        var numm:UInt8 = 0
        if num < 0 {
            let a = Int(UInt8.max) + Int(num) + 1
            numm = UInt8(a)
        }
        else { return String(num, radix:2).leftPad(toLength: 8, withPad: "0") }
        return String(numm, radix:2).leftPad(toLength: 8, withPad: "0")
    }
    
    static func toBinary(num:Int16) -> String {
        var numm:UInt16 = 0
        if num < 0 {
            let a = Int(UInt16.max) + Int(num) + 1
            numm = UInt16(a)
        }
        else { return String(num, radix:2).leftPad(toLength: 16, withPad: "0") }
        return String(numm, radix:2).leftPad(toLength: 16, withPad: "0")
    }
    
    static func toBinary(num:Int32) -> String {
        var numm:UInt32 = 0
        if num < 0 {
            let a = Int64(UInt32.max) + Int(num) + 1
            numm = UInt32(a)
        }
        else { return String(num, radix:2).leftPad(toLength: 32, withPad: "0") }
        return String(numm, radix:2).leftPad(toLength: 32, withPad: "0")
    }
    
    static func toBinary(str: String) -> Int8 {
        return Int8(str)!
    }
    
    static func toBinary(str: String) -> Int16 {
        return Int16(str)!
    }
    
    static func toBinary(str: String) -> Int32 {
        return Int32(str)!
    }
}
