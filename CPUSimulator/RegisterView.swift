//
//  RegisterView.swift
//  CPUSimulator
//
//  Created by Alic on 2016-10-26.
//  Copyright © 2016 4ZC3. All rights reserved.
//

import UIKit

class RegisterView: UIViewWrapper {
    
    internal let labelHeight = 24
    internal let labelWidth = 124
    internal let valueHeight = 72
    internal let valueWidth = 124
    
    lazy var regHeight: Int = {
        return self.labelHeight + self.valueHeight
    }()
    lazy var regWidth: Int = {
        return self.labelWidth
    }()
    
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
        
        regLabel.frame = (frame: CGRect(x: 0, y:0, width: labelWidth, height: labelHeight))
        regValue.frame = (frame: CGRect(x: 0, y:labelHeight, width: valueWidth, height: valueHeight))
        
        regLabel.font = regLabel.font.withSize(20)
        regValue.font = regValue.font.withSize(25)
        
        regLabel.textAlignment = NSTextAlignment.center
        regValue.textAlignment = NSTextAlignment.center
        
        regLabel.layer.borderWidth = 1
        regValue.layer.borderWidth = 1
        
        self.addSubview(regLabel)
        self.addSubview(regValue)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
