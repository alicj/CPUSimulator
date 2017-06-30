//
//  Path.swift
//  CPUSimulator
//
//  Created by Alic on 2017-06-25.
//  Copyright © 2017 4ZC3. All rights reserved.
//

import UIKit


class Path {
    var points: [CGPoint] = []
    var width: CGFloat = 0
    var height: CGFloat = 0
    var length: Double = 0
    var bezierPath: UIBezierPath = UIBezierPath()
    
    init(){}
    
    init(points: [CGPoint]) {
        self.points = points
        self.width = Path.calcWidth(points: points)
        self.height = Path.calcHeight(points: points)
        self.length = Path.calcLength(points: points)
        self.bezierPath = UIBezierPath()
        
        var pointsCopy = points
//        let offsetPoint = points[0]
        pointsCopy.remove(at: 0)
        
        self.bezierPath.move(to: points[0])
        for point in pointsCopy {
            self.bezierPath.addLine(to: point)
        }
    }
    
    init(points: [CGPoint], width: CGFloat, height: CGFloat, length: Double, bezierPath: UIBezierPath) {
        self.points = points
        self.width = width
        self.height = height
        self.length = length
        self.bezierPath = UIBezierPath(cgPath: bezierPath.cgPath.copy()!)
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = Path(points: points, width: width, height: height, length: length, bezierPath: bezierPath)
        return copy
    }
    
    
    class func calcWidth(points: [CGPoint]) -> CGFloat {
        var max: CGFloat = 0.0
        var min: CGFloat = CGFloat(Double.infinity)
        
        for point in points {
            if point.x > max {
                max = point.x
            }
            if point.x < min {
                min = point.x
            }
        }
        
        return max - min
    }
    
    class func calcHeight(points: [CGPoint]) -> CGFloat {
        var max: CGFloat = 0.0
        var min: CGFloat = CGFloat(Double.infinity)
        
        for point in points {
            if point.y > max {
                max = point.y
            }
            if point.y < min {
                min = point.y
            }
        }
        
        return max - min
    }
    
    class func calcLength(points: [CGPoint]) -> Double {
        var l: Double = 0.0
        
        for i in 0...points.count-2 {
            l += distanceBetween(a: points[i], b: points[i+1])
        }
        return l
    }
    
    class func distanceBetween(a: CGPoint, b: CGPoint) -> Double {
        let xDist = Double(a.x - b.x)
        let yDist = Double(a.y - b.y)
        return sqrt((xDist * xDist) + (yDist * yDist))
    }
    
//    internal func calcOffset(point: CGPoint, offPoint: CGPoint) -> CGPoint {
//        return CGPoint(x: point.x - offPoint.x, y: point.y - offPoint.y)
//    }
    
    func getCGPath() -> CGPath {
        return bezierPath.cgPath
    }
    
    func setLineWidth(lineWidth: CGFloat) {
        bezierPath.lineWidth = lineWidth
    }
}
