//
//  InstructionBlockView.swift
//  CPUSimulator
//
//  Created by Eric Xiao on 2016-08-29.
//  Copyright © 2016 4ZC3. All rights reserved.
//

import UIKit

class InstructionBlockView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.redColor().CGColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
