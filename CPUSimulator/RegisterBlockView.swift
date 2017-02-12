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
        positionViews()
        self.layer.backgroundColor = Sizes.debugColor
    }
    
    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        initRegisters()
        positionViews()
    }
    
    fileprivate func initRegisters() {
        for _ in 0..<9 {
            let register = RegisterView()
            registers += [register]
            addSubview(register)
        }
        
    }
    
    fileprivate func positionViews() {
        var regFrame = Sizes.register.frame
        
        for index in 0..<registers.count {
            if(index < 4) {
                regFrame.origin.x = CGFloat(index * (regWidth + margin))
            }
            // switch row after 4 registers
            else if (index < 8){
                regFrame.origin.x = CGFloat((index - 4) * (regWidth + margin))
                regFrame.origin.y = CGFloat(regHeight + margin)
            }
            else {
                regFrame.origin.x = CGFloat(3 * (regWidth + margin))
                regFrame.origin.y = CGFloat(regHeight * 2 + margin * 2)
            }
            
            registers[index].frame = regFrame
            registers[index].label = "Register " + String(index)
            setRegValue(regNum: index, regValue: "0")
        }
        
        registers[8].label = "Compare"
        setRegValue(regNum: 8, regValue: "")
        
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
