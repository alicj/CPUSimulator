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
    
    init() {
        memoryArray = []
    }
    
    init(count: Int) {
        memoryArray = Array(repeating: 0, count: count)
    }
    
    init(count: Double) {
        memoryArray = Array(repeating: 0, count: Int(count))
    }
    
    public func get(address: Int) -> Int {
        return memoryArray[address]
    }
    
    public func set(address: Int, value: Int){
        memoryArray[address] = value
    }
    
    public func count() -> Int {
        return memoryArray.count
    }
}
