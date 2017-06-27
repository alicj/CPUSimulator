//
//  PathView.swift
//  CPUSimulator
//
//  Created by Alic on 2017-06-19.
//  Copyright © 2017 4ZC3. All rights reserved.
//

import UIKit

class PathView: UIView {
    var path: Path = Path()
    
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
    
    init(path: Path) {
        // think about drawing all the paths on the same view
        self.path = path.copy() as! Path
        self.path.bezierPath.apply(CGAffineTransform(translationX: -path.points[0].x + 10, y: -path.points[0].y + 10))
        self.path.setLineWidth(lineWidth: PathData.lineWidth)

        let origin = self.path.points[0]
        
        super.init(frame: CGRect(x: origin.x - 10,
                                 y: origin.y - 10,
                                 width: path.width + CGFloat(2 * Sizes.padding),
                                 height: path.height + CGFloat(2 * Sizes.padding)))
        self.backgroundColor = UIColor(white: 1, alpha: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        
        UIColor.green.setStroke()
        self.path.bezierPath.stroke()
        
    }
    
    func getPath() -> UIBezierPath {
        return path.bezierPath
    }
    
    func getCgPath() -> CGPath {
        return path.bezierPath.cgPath
    }
    
}
