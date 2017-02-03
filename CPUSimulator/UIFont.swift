//
//  UIFont.swift
//  CPUSimulator
//
//  Created by Alic on 2017-02-01.
//  Copyright © 2017 4ZC3. All rights reserved.
//  http://stackoverflow.com/questions/8707082/set-a-default-font-for-whole-ios-app/40484460#40484460

import UIKit

extension UIFont {
    
    private struct AssociatedKey {
        static let appFontName = "Menlo-Regular"
        static let appFontBoldName = "Menlo-Bold"
        static let appFontItalicName = "Menlo-Italic"
    }
    
    
    class func mySystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AssociatedKey.appFontName, size: size)!
    }
    
    class func myBoldSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AssociatedKey.appFontBoldName, size: size)!
    }
    
    class func myItalicSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AssociatedKey.appFontItalicName, size: size)!
    }
    
    convenience init(myCoder aDecoder: NSCoder) {
        if let fontDescriptor = aDecoder.decodeObject(forKey: "UIFontDescriptor") as? UIFontDescriptor {
            if let fontAttribute = fontDescriptor.fontAttributes["NSCTFontUIUsageAttribute"] as? String {
                var fontName = ""
                switch fontAttribute {
                case "CTFontRegularUsage":
                    fontName = AssociatedKey.appFontName
                case "CTFontEmphasizedUsage", "CTFontBoldUsage":
                    fontName = AssociatedKey.appFontBoldName
                case "CTFontObliqueUsage":
                    fontName = AssociatedKey.appFontItalicName
                default:
                    if let name = fontDescriptor.fontAttributes["NSFontNameAttribute"] as? String {
                        fontName = name
                    }
                    else {
                        fontName = AssociatedKey.appFontName
                    }
                }
                self.init(name: fontName, size: fontDescriptor.pointSize)!
            }
            else {
                self.init(myCoder: aDecoder)
            }
        }
        else {
            self.init(myCoder: aDecoder)
        }
    }
    
    override open class func initialize() {
        if self == UIFont.self {
            let systemFontMethod = class_getClassMethod(self, #selector(systemFont(ofSize:)))
            let mySystemFontMethod = class_getClassMethod(self, #selector(mySystemFont(ofSize:)))
            method_exchangeImplementations(systemFontMethod, mySystemFontMethod)
            
            let boldSystemFontMethod = class_getClassMethod(self, #selector(boldSystemFont(ofSize:)))
            let myBoldSystemFontMethod = class_getClassMethod(self, #selector(myBoldSystemFont(ofSize:)))
            method_exchangeImplementations(boldSystemFontMethod, myBoldSystemFontMethod)
            
            let italicSystemFontMethod = class_getClassMethod(self, #selector(italicSystemFont(ofSize:)))
            let myItalicSystemFontMethod = class_getClassMethod(self, #selector(myItalicSystemFont(ofSize:)))
            method_exchangeImplementations(italicSystemFontMethod, myItalicSystemFontMethod)
            
            let initCoderMethod = class_getInstanceMethod(self, Selector("initWithCoder:"))
            let myInitCoderMethod = class_getInstanceMethod(self, #selector(UIFont.init(myCoder:)))
            method_exchangeImplementations(initCoderMethod, myInitCoderMethod)
        }
    }
}
