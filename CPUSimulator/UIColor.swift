//
//  UIColor.swift
//  CPUSimulator
//
//  Created by Alic on 2017-02-11.
//  Copyright © 2017 4ZC3. All rights reserved.
//http://www.codingexplorer.com/create-uicolor-swift/

import UIKit


extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        let newRed = CGFloat(red)/255
        let newGreen = CGFloat(green)/255
        let newBlue = CGFloat(blue)/255
        
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
    }
}
