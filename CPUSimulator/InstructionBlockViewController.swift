//
//  InstructionBlockViewController.swift
//  CPUSimulator
//
//  Created by Eric Xiao on 2016-09-01.
//  Copyright © 2016 4ZC3. All rights reserved.
//

import UIKit

class InstructionBlockViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    // move this into a class
    let level_arr = [0, 1, 2, 3, 4, 5]
    
    let instructionViewComponents = ["Instruction", "Register 1", "Regsiter 0", "Value"]
    let instruction_array = ["Load", "Store", "Load Immediate",
                             "Add", "Multiply", "And", "Or",
                             "Not", "Rotate", "Compare", "Branch",
                             "Halt"]
    
    let register_array = ["Register 0", "Register 1",
                          "Register 2", "Register 3",
                          "Register 4", "Register 5",
                          "Register 6", "Register 7",
                          " "]

    var int_arr = Array<Array<String>>()
    var reg_left_arr = Array<Array<String>>()
    var reg_right_arr = Array<Array<String>>()
    var val_arr = Array<Array<String>>()
    // move this into a class
    
    override func viewDidLoad() {
        instructionLoadLevelData()
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // The number of columns of data
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return instructionViewComponents.count
    }

    // The number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (component == 0) {
            return instructionViewComponents.count
        } else if (component == 1) {
            return instructionViewComponents.count
        } else if (component == 2) {
            return instructionViewComponents.count
        } else {
            return instructionViewComponents.count
        }
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (component == 0) {
            return int_arr[0][row]
        } else if (component == 1) {
            return reg_left_arr[0][row]
        } else if (component == 2) {
            return reg_right_arr[0][row]
        } else {
            return val_arr[0][row]
        }
    }

    // move this into a class
    private func instructionLoadLevelData() {
        print("Hello")
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
    // move this into a class
}
