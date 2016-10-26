//
//  DraggableView.swift
//  CPUSimulator
//
//  Created by Alic on 2016-10-25.
//  Copyright © 2016 4ZC3. All rights reserved.
//

import UIKit

class DraggableView: UIView {
    
    internal var lastLocation: CGPoint = CGPointZero
    private var label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    
    internal var labelText: String {
        get {
            return label.text!
        }
        set {
            label.text = newValue
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.blueColor().CGColor
        
        label.textColor = UIColor.blueColor()
        label.textAlignment = NSTextAlignment.Center
        self.addSubview(label)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("touches draggableView!")
        lastLocation = self.center
        self.superview?.bringSubviewToFront(self)
    }
    
}
