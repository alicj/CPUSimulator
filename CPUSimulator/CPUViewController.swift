//
//  ViewController.swift
//  CPUSimulator
//
//  Created by Alic on 2016-08-07.
//  Copyright © 2016 4ZC3. All rights reserved.
//

import UIKit

class CPUViewController: UIViewController {
    
    // variables for draggables
    private var selectedView:UIView?
    private var labelView = UILabel()
    private var dragOrigin = CGPoint()
    
    private var level = 0
    
    private var registerView = RegisterView(frame: CGRect(x: 450, y: 700, width: 560, height: 240))
    private var aluView = ALUView(frame: CGRect(x: 450, y: (700 + 240), width: 560, height: 240))
    private var memoryBlockView = MemoryBlockView(frame: CGRect(x: 50, y: (700-2*240), width: 240, height: 940))
    // instruction view
    private var instructionBlockController = InstructionBlockController()
    
    override func viewDidLoad() {
        // Do any additional setup after loading the view, typically from a nib.
        super.viewDidLoad()
        addInstructionViewController()
        
        self.view.addSubview(registerView)
        self.view.addSubview(aluView)
        self.view.addSubview(memoryBlockView)
        
        //        self.view.backgroundColor = UIColor.whiteColor()
        //        self.view.tintColor = UIColor.blueColor()
        
        setupGestures()
        
        processInstruction()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
    
    private func addInstructionViewController() {
        addChildViewController(instructionBlockController)
        self.view.addSubview(instructionBlockController.view)
        instructionBlockController.didMoveToParentViewController(self)
    }
    
    private func setupGestures() {
        let gesture = UIPanGestureRecognizer(target:self, action:#selector(pan(_:)))
        gesture.maximumNumberOfTouches = 1
        gesture.minimumNumberOfTouches = 1
        self.view.addGestureRecognizer(gesture)
    }
    
    @objc private func pan(rec:UIPanGestureRecognizer) {
        let p:CGPoint = rec.locationInView(self.view)
        
        switch rec.state {
        case .Began:
            print("began")
            selectedView = self.view.hitTest(p, withEvent: nil)
            
            if selectedView != nil {
                self.view.bringSubviewToFront(selectedView!)
            }
            
            if let subview = selectedView as? DraggableView {
                self.view.bringSubviewToFront(subview)
                dragOrigin = subview.lastLocation
            }
        case .Changed:
            if let subview = selectedView as? DraggableView {
                subview.center = p
            }
        case .Ended:
            print("ended")
            if let subview = selectedView as? DraggableView {
                //                if subview.frame.intersects(labelView.frame) {
                //                    print(true)
                //                }else{
                //                    print(false)
                //                    subview.center = dragOrigin
                //                }
                subview.center = dragOrigin
                
            }
            selectedView = nil
        default:
            selectedView = nil
        }
    }
    
    private func processInstruction(){
        let draggable = DraggableView(frame: CGRect(x: 500, y: (700-2*240), width: 50, height: 50))
        draggable.labelText = "5";
        self.view.addSubview(draggable)
        self.view.bringSubviewToFront(draggable)
        print(draggable.layer.zPosition)
    }
    
}
