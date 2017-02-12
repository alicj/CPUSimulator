//
//  RegisterView.swift
//  CPUSimulator
//
//  Created by Alic on 2016-10-26.
//  Copyright © 2016 4ZC3. All rights reserved.
//

import UIKit

class RegisterView: UIViewWrapper {
    
    fileprivate let regLabel = UILabel()
    fileprivate let regValue = UILabel()
    
    internal var label: String {
        get {
            return regLabel.text!
        }
        set {
            regLabel.text = newValue
        }
    }
    
    override var value: String {
        get {
            return regValue.text!
        }
        set {
            regValue.text = newValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        regLabel.frame = Sizes.register.label.frame
        regValue.frame = Sizes.register.value.frame
        
        regLabel.font = regLabel.font.withSize(Sizes.register.label.font)
        regValue.font = regValue.font.withSize(Sizes.register.value.font)
        
        regLabel.textAlignment = NSTextAlignment.center
        regValue.textAlignment = NSTextAlignment.center
        
        regLabel.layer.borderWidth = 1
        regValue.layer.borderWidth = 1
        
        self.addSubview(regLabel)
        self.addSubview(regValue)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
