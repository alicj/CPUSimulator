//
//  InstructionBlockViewController.swift
//  CPUSimulator
//
//  Created by Eric Xiao on 2016-09-01.
//  Copyright © 2016 4ZC3. All rights reserved.
//

import UIKit

class InstructionBlockController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    fileprivate var instructionBlockView = InstructionBlockView(frame: CGRect(x: 400, y: (700-2*240), width: 600, height: 240))
        
    fileprivate var level = 0
    fileprivate var programCounter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        instructionBlockView.delegate = self
        instructionBlockView.dataSource = self
        instructionBlockView.isUserInteractionEnabled = false
        instructionBlockView.layer.borderWidth = 2
        instructionBlockView.layer.borderColor = UIColor.red.cgColor
        super.view.addSubview(instructionBlockView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // The number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 5
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return LEVELS[level].count
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        switch component {
        case 0:
            return 20.0
        case 1:
            return 15 * 20.0
        case 2, 3, 4:
            return 3 * 20.0
        default:
            return 2 * 20.0
        }
    }
    
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent col: Int) -> String? {
        let instr = LEVELS[level][row]
        // try to get the values of each instruction as a list and call function all together
        switch instr {
        case let .load           (rg1, rg2, rg3):
            return processInstruction(row, col, "Load", [rg1, rg2, rg3])
        case let .store          (rg1, rg2, rg3):
            return processInstruction(row, col, "Store", [rg1, rg2, rg3])
        case let .loadImmediate  (rg, val):
            return processInstruction(row, col, "LoadImmediate", [rg, val])
        case let .add            (rg1, rg2, rg3):
            return processInstruction(row, col, "Add", [rg1, rg2, rg3])
        case let .multiply       (rg1, rg2, rg3):
            return processInstruction(row, col, "Multiply", [rg1, rg2, rg3])
        case let .and            (rg1, rg2, rg3):
            return processInstruction(row, col, "And", [rg1, rg2, rg3])
        case let .or             (rg1, rg2, rg3):
            return processInstruction(row, col, "Or", [rg1, rg2, rg3])
        case let .not            (rg1, rg2):
            return processInstruction(row, col, "Not", [rg1, rg2])
        case let .rotate         (rg1, rg2, val):
            return processInstruction(row, col, "Rotate", [rg1, rg2, val])
        case let .compare        (rg1, rg2):
            return processInstruction(row, col, "Compare", [rg1, rg2])
        case let .branch         (_, rg1): //FIXME
            if col == 0 {
                return "Branch"
            }else if col == 2 {
                return String(rg1)
            }
            return "" 
        case .halt:
            if col == 0 {
                return "Halt"
            }
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        for i in 0...(numberOfComponents(in: instructionBlockView) - 1) {
            if (i == component) {
                continue
            }
            instructionBlockView.selectRow(row, inComponent: i, animated: true)
        }
    }
    
    // ================
    // CUSTOM FUNCTIONS
    // ================
    
    internal func getCurrentInstruction() -> Instruction {
        return LEVELS[level][programCounter]
    }
    
    fileprivate func processInstruction(_ row: Int, _ col: Int, _ name: String, _ values: [Int]) -> String {
        if (col == 0) {
            return String(row)
        }
        else if (col == 1) {
            return name
        }else if (col == 4 && values.count == 2) {
            return ""
        }else {
            return String(values[col - 2])
        }
    
    }
    
    fileprivate func pickerSelectRow(_ row: Int, animated: Bool) {
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
    fileprivate func nextLevel() {
        if level == LEVELS.count - 1 {
            return
        }
        level += 1
        programCounter = 0
        instructionBlockView.reloadAllComponents()
        pickerSelectRow(0, animated: false)
    }
    
    internal func disableScrolling(){
        instructionBlockView.isUserInteractionEnabled = false
    }
    
    internal func enableScrolling(){
        instructionBlockView.isUserInteractionEnabled = true
    }

}
