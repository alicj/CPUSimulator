//
//  Util.swift
//  CPUSimulator
//
//  Created by Alic on 2017-03-04.
//  Copyright © 2017 4ZC3. All rights reserved.
//  https://ktrkathir.wordpress.com/2015/12/29/draw-or-set-a-border-for-particular-side-of-uiview-using-swift/comment-page-1/#comment-228

import UIKit

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
}
