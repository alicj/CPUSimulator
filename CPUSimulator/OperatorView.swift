//
//  OperatorView.swift
//  CPUSimulator
//
//  Created by Alic on 2016-12-22.
//  Copyright © 2016 4ZC3. All rights reserved.
//

import UIKit

class OperatorView: UIViewWrapper {
 
    
    fileprivate let opValue = UILabel()
    
    override internal var value: String {
        get {
            return opValue.text!
        }
        set {
            let size: CGSize = (newValue as NSString).size(attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: Sizes.operand.font)])
            if size.width > opValue.bounds.width {
                opValue.font = opValue.font.withSize(Sizes.font.medium)
            }
            else {
                opValue.font = opValue.font.withSize(Sizes.font.large)
            }
            opValue.text = newValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        opValue.frame = frame
        opValue.font = opValue.font.withSize(Sizes.operand.font)
        opValue.textAlignment = NSTextAlignment.center
        opValue.layer.borderWidth = 1
        self.addSubview(opValue)
        self.type = .operator
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
