//
//  DraggableView.swift
//  CPUSimulator
//
//  Created by Alic on 2016-10-25.
//  Copyright © 2016 4ZC3. All rights reserved.
//

import UIKit

class DraggableView: UIViewWrapper {
    
    static let SIZE:CGSize = CGSize(width: 50, height: 50)
    internal var lastLocation: CGPoint = CGPointZero
    lazy private var label: UILabel = UILabel(frame: CGRect(origin: CGPointZero, size: DraggableView.SIZE))
    lazy var property = String() // maybe should change this to `destination` to better suit its purpose


    
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
        
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.blueColor().CGColor
        
        label.textColor = UIColor.blueColor()
        label.textAlignment = NSTextAlignment.Center
        lastLocation = self.center

        self.addSubview(label)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
