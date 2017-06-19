//
//  RegisterBlockView.swift
//  CPUSimulator
//
//  Created by Eric Xiao on 2016-08-28.
//  Copyright © 2016 4ZC3. All rights reserved.
//

import UIKit

class RegisterBlockView: UIView {
        
    fileprivate let margin = Sizes.margin
    fileprivate let regWidth = Sizes.register.width
    fileprivate let regHeight = Sizes.register.height

    internal var registers = [RegisterView]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initRegisters()
        self.backgroundColor = Sizes.debugColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initRegisters()
    }
    
    fileprivate func initRegisters() {
        for i in 0..<9 {
            let register = RegisterView(frame: Sizes.register.frame)
            register.frame.origin.x += CGFloat(i % 3 * Int(regWidth + margin))
            register.label = "Register " + String(i)
            register.value = "0"
            
            let row = floor(Double(i) / 3.0)
            register.frame.origin.y += CGFloat(row * (regHeight + margin))
            
            
            if i == 8 {
                register.label = "Compare"
                register.value = " "
            }
           
            registers += [register]
            addSubview(register)
        }
    }
     
    internal func setRegValue(regNum n: Int, regValue v: String){
        registers[n].value = v
    }

    internal func getRegValue(regNum n: Int) -> String {
        return registers[n].label
    }
    
    internal func getRegView(regNum n: Int) -> UIViewWrapper {
        return registers[n]
    }
    
}
