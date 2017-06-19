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
        
        let op1 = OperandView(frame: Sizes.operand.frame)
        op1.frame.origin = Sizes.ALUBlock.originForFirstOperand
        op1.type = "operand1"
        
        let op2 = OperandView(frame: Sizes.operand.frame)
        op2.frame.origin = Sizes.ALUBlock.originForSecondOperand
        op2.type = "operand2"
        
        operatorView = OperatorView(frame: Sizes.operand.frame)
        operatorView.frame.origin = Sizes.ALUBlock.originForOperator
        
        let result = OperandView(frame: Sizes.operand.frame)
        result.frame.origin = Sizes.ALUBlock.originForResult
        
        operandArray.append(op1)
        operandArray.append(op2)
        operandArray.append(result)
        
        addSubview(op1)
        addSubview(op2)
        addSubview(operatorView)
        addSubview(result)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func getOperandView (index: Int) -> OperandView {
        return operandArray[index]
    }
    
    func getResultView () -> OperandView {
        return operandArray.last!
    }

    func getOperatorView () -> OperatorView {
        return operatorView
    }

}
