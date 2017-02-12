//
//  ALUView.swift
//  CPUSimulator
//
//  Created by Eric Xiao on 2016-08-28.
//  Copyright © 2016 4ZC3. All rights reserved.
//

import UIKit

class ALUBlockView: UIView {

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
    
    
    
    var operandArray = [OperandView]()
    var operatorView = OperatorView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let left = OperandView(frame: Sizes.operand.frame)
        left.value = "left"
        left.order = "Operand1"
        
        let right = OperandView(frame: Sizes.operand.frame)
        right.value = "right"
        right.frame.origin = CGPoint(x: 150, y: 0)
        right.order = "Operand2"
        
        operatorView = OperatorView(frame: Sizes.operand.frame)
        operatorView.value = "operator"
        operatorView.frame.origin = CGPoint(x: 75, y: 120)
        
        let bottom = OperandView(frame: Sizes.operand.frame)
        bottom.value = "bottom"
        bottom.frame.origin = CGPoint(x: 75, y: 240)
        
        operandArray.append(left)
        operandArray.append(right)
        operandArray.append(bottom)
        
        addSubview(left)
        addSubview(right)
        addSubview(operatorView)
        addSubview(bottom)
    }
    
    func getOperandView (_ index: Int) -> OperandView {
        return operandArray[index]
    }
    
    func getResultView () -> OperandView {
        return operandArray.last!
    }

    func getOperatorView () -> OperatorView {
        return operatorView
    }

}
