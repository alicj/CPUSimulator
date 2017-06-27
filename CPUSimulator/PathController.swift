//
//  PathController.swift
//  CPUSimulator
//
//  Created by Alic on 2017-06-19.
//  Copyright © 2017 4ZC3. All rights reserved.
//

import UIKit

class PathController: UIViewController {
    
    var PATHS: Dictionary<String, Path> = [:]
    var pathViews: [PathView] = []
    var timer: Timer?
    var times: Int = 0
    
    var speed: Double = 400.0 // px/s
    
    var pathKey: String = ""
    var digits: [String] = []
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: Bundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        PATHS["instructionBlockToRegisterBlock"] = Path(points: PathData.instructionBlock.toRegisterBlock)
        PATHS["instructionBlockToALUBlock"] = Path(points: PathData.instructionBlock.toALUBlock)
        PATHS["registerBlockToALUBlock"] = Path(points: PathData.registerBlock.toALUBlock)
        PATHS["registerBlockToMemoryBlock"] = Path(points: PathData.registerBlock.toMemoryBlock)
        PATHS["ALUBlockToRegisterBlock"] = Path(points: PathData.ALUBlock.toRegisterBlock)
        PATHS["memoryBlockToRegisterBlock"] = Path(points: PathData.memoryBlock.toRegisterBlock)
        
        pathViews.append(PathView(path: PATHS["instructionBlockToRegisterBlock"]!))
        pathViews.append(PathView(path: PATHS["instructionBlockToALUBlock"]!))
        pathViews.append(PathView(path: PATHS["registerBlockToALUBlock"]!))
        pathViews.append(PathView(path: PATHS["memoryBlockToRegisterBlock"]!))
        
        
        UIColor.green.setStroke()
        
        for view in pathViews {
            self.view.addSubview(view)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
    
    func animate(pathKey: String, digits: String) {
        self.pathKey = pathKey
        self.digits = digits.characters.map { String($0) }
        startTimer(delay: 0)
    }
    
    internal func startTimer(delay: Double) {
        timer = Timer.scheduledTimer(timeInterval: delay, target: self, selector: #selector(runAnimation), userInfo: nil, repeats: false)
    }
    
    func runAnimation(_ timer: Timer){
        print("ran \(times) times")
        if let currentPath: Path = PATHS[pathKey] {
            let duration = currentPath.length / speed
            
            if times >= digits.count{
                times = 0
                return
            }else {
                let i = digits[times]
                times += 1
                var d1 = UILabel()
                
                startTimer(delay: 0.1)
                
                
                UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: .calculationModePaced, animations: {
                    
                    d1 = UILabel(frame: CGRect(x: 100, y: 100, width: 30, height: 30))
                    d1.text = String(i)
                    d1.layer.backgroundColor = UIColor.red.cgColor
                    d1.layer.borderWidth = 1
                    d1.layer.borderColor = UIColor.black.cgColor
                    d1.textColor = UIColor.black
                    
                    self.view.addSubview(d1)
                    
                    
                    let anim = CAKeyframeAnimation(keyPath: "position")
                    anim.path = currentPath.getCGPath()
                    anim.duration = duration
                    //
                    //                let tempPath = UIBezierPath(cgPath: currentPath.getCGPath())
                    //                UIColor.red.setStroke()
                    //                tempPath.stroke()
                    
                    d1.layer.add(anim, forKey: "animate position along path \(i)")
                    
                }, completion: { finished in
                    if finished {
                        print (finished)
                        d1.removeFromSuperview()
                    }
                    return
                })
            }
        }
    }
    
}
