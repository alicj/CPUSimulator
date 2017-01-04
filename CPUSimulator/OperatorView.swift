//
//  OperatorView.swift
//  CPUSimulator
//
//  Created by Alic on 2016-12-22.
//  Copyright © 2016 4ZC3. All rights reserved.
//

import UIKit

class OperatorView: UIViewWrapper {

    static let height = 60
    static let width = 60
    
    
    private let opValue = UILabel()
    
    override internal var value: String {
        get {
            return opValue.text!
        }
        set {
            opValue.text = newValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        opValue.frame = (frame: CGRect(x: 0, y:0, width: OperatorView.width, height: OperatorView.height))
        
        opValue.font = opValue.font.fontWithSize(20)
        opValue.textAlignment = NSTextAlignment.Center
        opValue.layer.borderWidth = 1
        
        self.addSubview(opValue)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
