//
//  ALUView.swift
//  CPUSimulator
//
//  Created by Eric Xiao on 2016-08-28.
//  Copyright © 2016 4ZC3. All rights reserved.
//

import UIKit

class ALUView: UIView {

    let aluRegisterWidth = 90
    let aluRegisterHeight = 50
    
    let aluButtonWidth = 54
    let aluButtonHeight = 42
    
    let margin = 16
    
    var aluButtonXOffset = 0
    var aluButtonYOffset = 0
    var questionmarkXOffset = 0
    var questionMarkYOffset = 0
    
    var labelRightX = 0
    var labelLeftX = 0
    var labelY = 0
    var labelResultX = 0
    var labelResultY = 0
    
    let buttonOffsetFromBottom = 42 + Int(16/2)
    let buttonOffsetFromMiddle = 2*54 + Int(1.5*16)
    let questionMarkMiddleX = Int(42/2)
    let questionMarkMiddleY = Int(54/2)
    
    let registerMiddleX = Int(90/2)
    
    let aluRegisters = ["addL","addR", "addResult",
                "subL", "subR", "subResult",
                "multL", "multR", "multResult",
                "compL", "compR", "compResult"]
    let aluButtons = ["add", "sub", "multiple", "complement","?"]
    
    var aluRegistersArray = [UILabel]()
    var aluButtonsArray = [UIButton]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // add the buttons to view & ?
        initButtons()
        // add the registers
        initRegister()
        // initialize the offsets for buttons and labels
        initOffset()
        
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.redColor().CGColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // update the alu button features
    override func layoutSubviews() {
        moveButtons()
        moveLabels()
    }
    
    func initOffset(){
        aluButtonXOffset = Int(self.bounds.midX) - buttonOffsetFromMiddle
        aluButtonYOffset = Int(self.bounds.maxY) - buttonOffsetFromBottom
        questionmarkXOffset = Int(self.bounds.midX) - questionMarkMiddleX
        questionMarkYOffset = Int(self.bounds.midY) - questionMarkMiddleY
        
        labelRightX = Int(self.bounds.midX) - 8 - aluRegisterWidth
        labelLeftX = Int(self.bounds.midX) + 8
        labelY = Int(self.bounds.midY) - 8 - aluRegisterHeight
        labelResultX = Int(self.bounds.midX) - registerMiddleX
        labelResultY = Int(self.bounds.midY) + Int(aluButtonHeight/2) + 8
    }
    
    func initButtons(){
        for _ in 0..<5 {
            let button = UIButton()
            aluButtonsArray += [button]
            addSubview(button)
        }
    }
    
    func initRegister(){
        for _ in 0..<3 {
            let label = UILabel()
            label.textAlignment = NSTextAlignment.Center
            aluRegistersArray += [label]
            addSubview(label)
        }
    }
    
    func moveButtons(){
        var buttonFrame = CGRect(x: 0, y: 0, width: aluButtonWidth, height: aluButtonHeight)
        //        var registerFrame = CGRect(x: 0, y: 0, width: aluRegisterWidth, height: aluRegisterHeight)
        
        for index in 0..<aluButtonsArray.count {
            if(index < 4) {
                buttonFrame.origin.x = CGFloat(index * (aluButtonWidth + margin) + aluButtonXOffset)
                buttonFrame.origin.y = CGFloat(aluButtonYOffset)
                
            }
            else {
                buttonFrame.origin.x = CGFloat(questionmarkXOffset)
                buttonFrame.origin.y = CGFloat(questionMarkYOffset)
            }
            aluButtonsArray[index].frame = buttonFrame
            aluButtonsArray[index].setTitle(aluButtons[index], forState: UIControlState.Normal)
            aluButtonsArray[index].backgroundColor = UIColor.redColor()
        }
    }
    
    func moveLabels(){
        
        let labelLeftFrame = CGRect(x: labelLeftX, y: labelY, width: aluRegisterWidth, height: aluRegisterHeight)
        let labelRightFrame = CGRect(x: labelRightX, y: labelY, width: aluRegisterWidth, height: aluRegisterHeight)
        let labelResultFrame = CGRect(x: labelResultX, y: labelResultY, width: aluRegisterWidth, height: aluRegisterHeight)
        
        aluRegistersArray[0].frame = labelLeftFrame
        aluRegistersArray[1].frame = labelRightFrame
        aluRegistersArray[2].frame = labelResultFrame
        
        aluRegistersArray[0].text = "Left"
        aluRegistersArray[1].text = "Right"
        aluRegistersArray[2].text = "Results"
    }
}
