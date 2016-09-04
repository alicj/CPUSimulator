//
//  InstructionBlockView.swift
//  CPUSimulator
//
//  Created by Eric Xiao on 2016-08-29.
//  Copyright © 2016 4ZC3. All rights reserved.
//

import UIKit

class InstructionBlockView: UIPickerView {
    
    var instructions = UIPickerView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        instructions = initInstructions()
        self.addSubview(instructions)
        
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.redColor().CGColor
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initInstructions() -> UIPickerView{
        let instructions = UIPickerView(frame: CGRect(
                                        x: self.bounds.origin.x,
                                        y: self.bounds.origin.y,
                                        width: self.bounds.width,
                                        height: self.bounds.height))
        return instructions
    }
}
