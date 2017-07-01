//
//  PathController.swift
//  CPUSimulator
//
//  Created by Alic on 2017-06-19.
//  Copyright © 2017 4ZC3. All rights reserved.
//

import UIKit

protocol PathDelegate {
    func updateTargetView(nthDigit: Int, withValue: String)
}

class PathController: UIViewController {
    
    var PATHS: Dictionary<String, Path> = [:]
    var pathViews: [PathView] = []
    var timer: Timer?
    var nthDigit: Int = 0
    var nthDigitStack: [Int] = []
    
    var speed: Double = 400.0 // px/s
    
    var pathKey: String = ""
    var digits: [String] = []
    
    var delegate: PathDelegate?
    
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
        if let currentPath: Path = PATHS[pathKey] {
            let duration = currentPath.length / speed
            
            if nthDigit >= digits.count{
                nthDigit = 0
                return
            }else {
                let i = digits[nthDigit]
                nthDigitStack.append(nthDigit)
                nthDigit += 1
                var d1 = UILabel()
                
                startTimer(delay: 0.25)
                
                UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: .calculationModePaced, animations: {
                    
                    d1 = UILabel(frame: CGRect(x: 100, y: 100, width: 20, height: 20))
                    d1.text = String(i)
                    d1.textAlignment = .center
                    d1.layer.backgroundColor = UIColor(white: 1, alpha: 0).cgColor
                    d1.textColor = UIColor.black
                    
                    self.view.addSubview(d1)
                    
                    
                    let anim = CAKeyframeAnimation(keyPath: "position")
                    anim.path = currentPath.getCGPath()
                    anim.duration = duration
                    
                    d1.layer.add(anim, forKey: "animate position along path \(i)")
                    
                }, completion: { finished in
                    if finished {
                        if !self.nthDigitStack.isEmpty {
                            //  let nth = self.digits.count - self.nthDigitStack.removeLast() - 1
                            let nth = self.nthDigitStack.removeLast()
                            self.delegate?.updateTargetView(nthDigit: nth, withValue: d1.text!)
                            d1.removeFromSuperview()
                        }
                    }
                    return
                })
            }
        }
    }
    
}
