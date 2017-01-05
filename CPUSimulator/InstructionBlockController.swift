//
//  InstructionBlockViewController.swift
//  CPUSimulator
//
//  Created by Eric Xiao on 2016-09-01.
//  Copyright © 2016 4ZC3. All rights reserved.
//

import UIKit

class InstructionBlockController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var instructionBlockView = InstructionBlockView(frame: CGRect(x: 500, y: (700-2*240), width: 500, height: 240))
    
    // debug button
    private var nextLevelButton = UIButton(frame: CGRect(x: 500, y: 50, width: 100, height: 50))
    
    private var level = 0
    private var programCounter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        instructionBlockView.delegate = self
        instructionBlockView.dataSource = self
        instructionBlockView.userInteractionEnabled = false
        instructionBlockView.layer.borderWidth = 2
        instructionBlockView.layer.borderColor = UIColor.redColor().CGColor
        super.view.addSubview(instructionBlockView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // The number of columns of data
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 4
    }
    
    // The number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return LEVELS[level].count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent col: Int) -> String? {
        let instr = LEVELS[level][row]
        // try to get the values of each instruction as a list and call function all together
        switch instr {
        case let .Load           (rg1, rg2, rg3):
            return processInstruction(col, name: "Load", values: [rg1, rg2, rg3])
        case let .Store          (rg1, rg2, rg3):
            return processInstruction(col, name: "Store", values: [rg1, rg2, rg3])
        case let .LoadImmediate  (rg, val):
            return processInstruction(col, name: "LoadImmediate", values: [rg, val])
        case let .Add            (rg1, rg2, rg3):
            return processInstruction(col, name: "Add", values: [rg1, rg2, rg3])
        case let .Multiply       (rg1, rg2, rg3):
            return processInstruction(col, name: "Multiply", values: [rg1, rg2, rg3])
        case let .And            (rg1, rg2, rg3):
            return processInstruction(col, name: "And", values: [rg1, rg2, rg3])
        case let .Or             (rg1, rg2, rg3):
            return processInstruction(col, name: "Or", values: [rg1, rg2, rg3])
        case let .Not            (rg1, rg2):
            return processInstruction(col, name: "Not", values: [rg1, rg2])
        case let .Rotate         (rg1, rg2, val):
            return processInstruction(col, name: "Rotate", values: [rg1, rg2, val])
        case let .Compare        (rg1, rg2):
            return processInstruction(col, name: "Compare", values: [rg1, rg2])
        case let .Branch         (_, rg1): //FIXME
            if col == 0 {
                return "Branch"
            }else if col == 2 {
                return String(rg1)
            }
            return ""
        case .Halt:
            if col == 0 {
                return "Halt"
            }
            return ""
        }
    }
    
    // ================
    // CUSTOM FUNCTIONS
    // ================
    
    internal func getCurrentInstruction() -> Instruction {
        return LEVELS[level][programCounter]
    }
    
    private func processInstruction(col: Int, name: String, values: [Int]) -> String {
        if (col == 0) {
            return name
        }else if (col == 3 && values.count == 2) {
            return ""
        }else {
            return String(values[col-1])
        }
    }
    
    private func pickerSelectRow(row: Int, animated: Bool) {
        for i in 0...(instructionBlockView.numberOfComponents - 1) {
            instructionBlockView.selectRow(row, inComponent: i, animated: animated)
        }
    }
    
    internal func nextStage () {
        // still in the same level
        if(programCounter < LEVELS[level].count - 1) {
            programCounter += 1
            // move picker items down by 1
            pickerSelectRow(programCounter, animated: true)
        }
            // move to next level
        else {
            nextLevel()
        }
    }
    
    // reload the view with new components equal to new level
    private func nextLevel() {
        if level == LEVELS.count - 1 {
            return
        }
        level += 1
        programCounter = 0
        instructionBlockView.reloadAllComponents()
        pickerSelectRow(0, animated: false)
    }

}
