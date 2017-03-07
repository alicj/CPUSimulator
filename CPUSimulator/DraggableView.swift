//
//  DraggableView.swift
//  CPUSimulator
//
//  Created by Alic on 2016-10-25.
//  Copyright © 2016 4ZC3. All rights reserved.
//

import UIKit

class DraggableView: UIViewWrapper {
    
    internal var lastLocation: CGPoint = CGPoint.zero
    internal var type = ""

    lazy fileprivate var label: UILabel = UILabel()

    
    override var value: String {
        get {
            return label.text!
        }
        set {
            label.text = newValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        label = UILabel(frame: Sizes.draggable.frame)
        
        self.layer.borderWidth = 1
        
        label.textAlignment = NSTextAlignment.center
        label.font = label.font.withSize(Sizes.draggable.font)
        lastLocation = self.center

        self.addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    internal func setFontSize(size: CGFloat) {
        label.font = label.font.withSize(size)
    }
    
    
}
