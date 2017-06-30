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

    fileprivate var label: UILabel = UILabel()

    
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
//        self.layer.borderWidth = 1
        label.textColor = Sizes.draggable.color
        label.textAlignment = NSTextAlignment.center
        label.font = label.font.withSize(Sizes.draggable.font)
        lastLocation = self.center
        self.addSubview(label)
    }
    
    convenience init(frame: CGRect, type: ViewType) {
        self.init(frame: frame)
        self.type = type
    }
    
    convenience init(frame: CGRect, value: String, type: ViewType) {
        self.init(frame: frame)
        self.value = value
        self.type = type
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    internal func setFontSize(size: CGFloat) {
        label.font = label.font.withSize(size)
    }
    
    
}
