//
//  MemoryModel.swift
//  CPUSimulator
//
//  Created by Alic on 2017-02-15.
//  Copyright © 2017 4ZC3. All rights reserved.
//

import Foundation

class Memory {
    fileprivate var memoryArray: [Int]
    
    init(count: Int) {
        memoryArray = Array(repeating: 0, count: count)
    }
    
    public func get(pointer: Int) -> Int {
        return memoryArray[pointer]
    }
    
    public func set(pointer: Int, value: Int){
        memoryArray[pointer] = value
    }
    
    public func count() -> Int {
        return memoryArray.count
    }
}
