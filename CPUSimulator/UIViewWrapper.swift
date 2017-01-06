//
//  UIViewWrapper.swift
//  CPUSimulator
//
//  Created by Alic on 2016-11-29.
//  Copyright © 2016 4ZC3. All rights reserved.
//

import UIKit

class UIViewWrapper: UIView {
    
    var value: String {
        get {
            return self.value
        }
        set {
            self.value = newValue
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
 
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
