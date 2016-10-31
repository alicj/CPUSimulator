//
//  RegisterBlockView.swift
//  CPUSimulator
//
//  Created by Eric Xiao on 2016-08-28.
//  Copyright © 2016 4ZC3. All rights reserved.
//

import UIKit

class RegisterBlockView: UIView {
        
    private let margin = 16
    private var regWidth: Int
    private var regHeight: Int

    internal var registers = [RegisterView]()
    
    override init(frame: CGRect) {
        regWidth = RegisterView().regWidth
        regHeight = RegisterView().regHeight
        super.init(frame: frame)

        initRegisters()
        positionViews()
        
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.redColor().CGColor
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initRegisters() {
        for _ in 0..<8 {
            let register = RegisterView()
            registers += [register]
            addSubview(register)
        }
    }
    
    private func positionViews() {
        var regFrame = CGRect(x: 0, y:0, width: regWidth, height: regHeight)
        
        for index in 0..<registers.count {
            if(index < 4) {
                regFrame.origin.x = CGFloat(index * (regWidth + margin))
            }
            // switch row after 4 registers
            else {
                regFrame.origin.x = CGFloat((index - 4) * (regWidth + margin))
                regFrame.origin.y = CGFloat(regHeight + margin)
            }
            
            registers[index].frame = regFrame
            registers[index].labelValue = "Register " + String(index)
            setRegValue(regNum: index, regValue: 0)
        }

    }
    
    internal func setRegValue(regNum n: Int, regValue v: Int){
        registers[n].regValue = String(v)
    }

    internal func getRegValue(regNum n: Int, regValue v: Int) -> String {
        return registers[n].regValue
    }
    
    internal func getRegView(regNum n: Int) -> UIView {
        return registers[n]
    }
}