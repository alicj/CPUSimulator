//
//  ALUView.swift
//  CPUSimulator
//
//  Created by Eric Xiao on 2016-08-28.
//  Copyright © 2016 4ZC3. All rights reserved.
//

import UIKit

class ALUBlockView: UIView {

    var operandArray = [OperandView]()
    var operatorView = OperatorView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let left = OperandView(frame: Sizes.operand.frame)
        left.type = "operand1"
        
        let right = OperandView(frame: Sizes.operand.frame)
        right.frame.origin = Sizes.ALUBlock.rightOperandOrigin
        right.type = "operand2"
        
        operatorView = OperatorView(frame: Sizes.operand.frame)
        operatorView.frame.origin = Sizes.ALUBlock.operatorOrigin
        
        let bottom = OperandView(frame: Sizes.operand.frame)
        bottom.frame.origin = Sizes.ALUBlock.resultOrigin
        
        operandArray.append(left)
        operandArray.append(right)
        operandArray.append(bottom)
        
        addSubview(left)
        addSubview(right)
        addSubview(operatorView)
        addSubview(bottom)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
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
