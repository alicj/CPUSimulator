//
//  Util.swift
//  CPUSimulator
//
//  Created by Alic on 2017-03-04.
//  Copyright © 2017 4ZC3. All rights reserved.
//  https://ktrkathir.wordpress.com/2015/12/29/draw-or-set-a-border-for-particular-side-of-uiview-using-swift/comment-page-1/#comment-228

import UIKit
import Foundation

class Util {
    
    static func setBottomBorder(view: UIView)->UIView{
        return setBottomBorder(view: view, color: UIColor.black.cgColor, thickness: 1);
    }
    
    static func setBottomBorder(view: UIView, color: CGColor, thickness: Int) -> UIView {
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x: 0, y: view.frame.height-1, width: view.frame.width, height: CGFloat(thickness))
        bottomBorder.backgroundColor = color
        view.layer.addSublayer(bottomBorder)
        
        return view;
    }
    
    
    static func makeColorGradient(frequency1: Double, frequency2: Double , frequency3: Double, phase1: Double, phase2: Double, phase3: Double, len: Double, center: Double = 128.0, width: Double = 127.0) -> UIColor {
        
        let r = sin(frequency1 * len + phase1) * width + center;
        let g = sin(frequency2 * len + phase2) * width + center;
        let b = sin(frequency3 * len + phase3) * width + center;

        return UIColor(red: Int(r), green: Int(g), blue: Int(b))
    }
}
