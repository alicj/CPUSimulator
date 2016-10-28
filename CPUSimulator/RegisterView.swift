//
//  RegisterView.swift
//  CPUSimulator
//
//  Created by Alic on 2016-10-26.
//  Copyright © 2016 4ZC3. All rights reserved.
//

import UIKit

class RegisterView: UIView {
    
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
    
    private let label = UILabel()
    private let value = UILabel()
    
    internal var labelValue: String {
        get {
            return label.text!
        }
        set {
            label.text = newValue
        }
    }
    
    internal var regValue: String {
        get {
            return value.text!
        }
        set {
            value.text = newValue
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label.frame = (frame: CGRect(x: 0, y:0, width: labelWidth, height: labelHeight))
        value.frame = (frame: CGRect(x: 0, y:labelHeight, width: valueWidth, height: valueHeight))
        
        label.text = "Register 0"
        value.text = "0"
        
        label.font = label.font.fontWithSize(20)
        value.font = value.font.fontWithSize(25)
        
        label.textAlignment = NSTextAlignment.Center
        value.textAlignment = NSTextAlignment.Center
        
        label.layer.borderWidth = 1
        value.layer.borderWidth = 1
        
        self.addSubview(label)
        self.addSubview(value)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
