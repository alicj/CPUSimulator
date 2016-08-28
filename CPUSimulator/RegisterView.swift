//
//  RegisterView.swift
//  CPUSimulator
//
//  Created by Eric Xiao on 2016-08-28.
//  Copyright © 2016 4ZC3. All rights reserved.
//

import UIKit

class RegisterView: UIView {
    
    let labelHeight = 24
    let labelWidth = 124
    let valueHeight = 72
    let valueWidth = 124
    let margin = 16
    
    var registerLabels = [UILabel]()
    var registerValues = [UILabel]()
    
    // TODO initializing with a view in the story board
    // required init?(coder aDecoder: NSCoder) {
    
    // TODO initializing with making an instance of the UIView Class in Controller
    override init(frame: CGRect) {
        let frameWidth = (4 * labelWidth) + (4 * margin)
        let frameHeight = (2 * labelHeight) + (2 * valueHeight) + (3 * margin)
        
        super.init(frame: CGRect(x: Int(frame.origin.x), y: Int(frame.origin.y), width: frameWidth, height: frameHeight))
        
        for _ in 0..<8 {
            let label = UILabel()
            let register = UILabel()
            
            label.font = label.font.fontWithSize(20)
            register.font = register.font.fontWithSize(25)
            
            label.textAlignment = NSTextAlignment.Center
            register.textAlignment = NSTextAlignment.Center
            
            registerLabels += [label]
            registerValues += [register]
            
            addSubview(label)
            addSubview(register)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    // update the register label frames and positon
    override func layoutSubviews() {
        var labelFrame = CGRect(x: 0, y:0, width: labelWidth, height: labelHeight)
        var valueFrame = CGRect(x: 0, y:0, width: labelWidth, height: labelHeight)
        for index in 0..<registerValues.count {
            if(index < 4) {
                labelFrame.origin.x = CGFloat(index * (labelWidth + margin))
                
                valueFrame.origin.x = CGFloat(index * (valueWidth + margin))
                valueFrame.origin.y = CGFloat(margin + labelHeight)
            }
            // switch row after 4 registers
            else {
                labelFrame.origin.x = CGFloat((index - 4) * (labelWidth + margin))
                labelFrame.origin.y = CGFloat(labelHeight + valueHeight + 2 * margin)
                
                valueFrame.origin.x = CGFloat((index - 4) * (valueWidth + margin))
                valueFrame.origin.y = CGFloat(2 * labelHeight + valueHeight + 3 * margin)
            }
            registerLabels[index].frame = labelFrame
            registerValues[index].frame = valueFrame
            registerLabels[index].text = "Register " + String(index)
            registerValues[index].text = String(0)
        }
    }
    
    /*
     // Only override drawRect: if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func drawRect(rect: CGRect) {
     // Drawing code
     }
     */
}