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

    private let instructionContent = InstructionBlockData()
    private var level = 0
    private var stage = 0
    
    override func viewDidLoad() {
        instructionBlockView.delegate = self
        instructionBlockView.dataSource = self
        super.view.addSubview(instructionBlockView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // The number of columns of data
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        let rows = instructionContent.getColumns()
        return rows
    }

    // The number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let columns = instructionContent.getRows(level)
        return columns
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let data = instructionContent.getColumnContent(level, row: row, col: component)
        return data
    }
    
    func nextStage () {
        // still in the same level
        if(stage < instructionContent.getRows(level)) {
            stage += 1
        }
        // move to next level
        else {
            nextLevel()
        }
    }
    
    // reload the view with new components equal to new level
    func nextLevel() {
        level += 1
        stage = 0
        instructionBlockView.reloadAllComponents()
    }
}
