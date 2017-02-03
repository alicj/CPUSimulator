//
//  OperandView.swift
//  CPUSimulator
//
//  Created by Alic on 2016-12-22.
//  Copyright © 2016 4ZC3. All rights reserved.
//

import UIKit

class OperandView: UIViewWrapper {
    
    static let height = 80
    static let width = 80
    
    
    fileprivate let opValue = UILabel()
    
    override internal var value: String {
        get {
            return opValue.text!
        }
        set {
            opValue.text = newValue
        }
    }
    
    lazy internal var order: String = String()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        opValue.frame = (frame: CGRect(x: 0, y:0, width: OperandView.width, height: OperandView.height))
        
        opValue.font = opValue.font.withSize(20)
        opValue.textAlignment = NSTextAlignment.center
        opValue.layer.borderWidth = 1
        
        self.addSubview(opValue)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}