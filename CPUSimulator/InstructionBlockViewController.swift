//
//  InstructionBlockViewController.swift
//  CPUSimulator
//
//  Created by Eric Xiao on 2016-09-01.
//  Copyright © 2016 4ZC3. All rights reserved.
//

import UIKit

class InstructionBlockViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var instructionBlockView = InstructionBlockView(frame: CGRect(x: 500, y: (700-2*240), width: 500, height: 240))
    
    // debug button
    var nextLevelButton = UIButton(frame: CGRect(x: 500, y: 50, width: 100, height: 50))
    
    private let instructionContent = InstructionBlockData()
    private var level = 0
    private var programCounter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        instructionBlockView.delegate = self
        instructionBlockView.dataSource = self
        //        instructionBlockView.userInteractionEnabled = false
        super.view.addSubview(instructionBlockView)
        
        nextLevelButton.backgroundColor = .blackColor()
        nextLevelButton.setTitle("Next Instr", forState: .Normal)
        nextLevelButton.addTarget(self, action: #selector(buttonAction), forControlEvents: .TouchUpInside)
        
        super.view.addSubview(nextLevelButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // The number of columns of data
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        let columns = instructionContent.getColumns()
        return columns
    }

    // The number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let rows = instructionContent.getRows(level)
        return rows
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let data = instructionContent.getColumnContent(level, row: row, col: component)
        return data
    }
    
    func pickerSelectRow(row: Int, animated: Bool) {
        for i in 0...(instructionBlockView.numberOfComponents - 1) {
            instructionBlockView.selectRow(row, inComponent: i, animated: animated)
        }
    }


    func nextStage () {
        // still in the same level
        if(programCounter < instructionContent.getRows(level) - 1) {
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
    func nextLevel() {
        level += 1
        programCounter = 0
        instructionBlockView.reloadAllComponents()
        pickerSelectRow(0, animated: false)
    }
    
    func buttonAction() {
        nextStage();
    }
}
