//
//  InstructionBlockData.swift
//  CPUSimulator
//
//  Created by Eric Xiao on 2016-09-04.
//  Copyright © 2016 4ZC3. All rights reserved.
//

import Foundation

class InstructionBlockData {
    // move this into a class
    private let level_arr = [0, 1, 2, 3, 4, 5]
    
    private let instructionViewComponents = ["Instruction", "Register 1", "Regsiter 0", "Value"]
    
    private let instruction_array = ["Load", "Store", "Load Immediate",
                                     "Add", "Multiply", "And", "Or",
                                     "Not", "Rotate", "Compare", "Branch",
                                     "Halt"]
    
    private let register_array = ["Register 0", "Register 1",
                                  "Register 2", "Register 3",
                                  "Register 4", "Register 5",
                                  "Register 6", "Register 7",
                                  " "]
    
    private var int_arr = Array<Array<String>>()
    private var reg_left_arr = Array<Array<String>>()
    private var reg_right_arr = Array<Array<String>>()
    private var val_arr = Array<Array<String>>()
    
    init() {
        instructionLoadLevelData()
    }
    
    private func instructionLoadLevelData() {
        int_arr = [[instruction_array[2], instruction_array[2],instruction_array[3],
            instruction_array[2], instruction_array[1]],
                   [],
                   [],
                   [],
                   [],
                   []]
        reg_left_arr = [[register_array[0], register_array[1], register_array[2],
            register_array[3], register_array[3]],
                        [],
                        [],
                        [],
                        [],
                        []]
        reg_right_arr = [[register_array[8], register_array[8], register_array[0],
            register_array[8], register_array[8]],
                         [],
                         [],
                         [],
                         [],
                         []]
        val_arr = [["10", "12", register_array[1], "5", " "],
                   [],
                   [],
                   [],
                   [],
                   []]
    }
    
    func getRows(level: Int) -> Int {
        return int_arr[level].count
    }
    
    func getColumns() -> Int {
        return instructionViewComponents.count
    }
    
    func getColumnContent(level: Int, row: Int, col: Int) -> String {
        var data = " "
        if(col == 0) {
            data = int_arr[level][row]
        } else if(col == 1) {
            data = reg_left_arr[level][row]
        } else if(col == 2) {
            data = reg_right_arr[level][row]
        } else if(col == 3) {
            data = val_arr[level][row]
        }
        return data
    }
}