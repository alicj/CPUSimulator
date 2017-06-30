//
//  String.swift
//  CPUSimulator
//
//  Created by Alic on 2017-02-01.
//  Copyright © 2017 4ZC3. All rights reserved.
//

import Foundation

extension String {
    func leftPad(toLength: Int,withPad:String) -> String {
        let toPad = toLength - self.characters.count;
        if toPad < 1 {
            return self;
        }
        return "".padding(toLength: toPad, withPad: withPad, startingAt: 0) + self;
    }
    
    func evenPad(toLength: Int, withPad: String) -> String {
        let leftPad = (toLength - self.characters.count) / 2
        let rightPad = toLength - self.characters.count - leftPad
        if leftPad < 1 && rightPad < 1 {
            return self;
        }
        return "".padding(toLength: leftPad, withPad: withPad, startingAt: 0) + self.padding(toLength: self.characters.count + rightPad, withPad: withPad, startingAt: 0)
    }
    
    func toBinary(string: String) {
        
    }

}
