//
//  CPUViewController.swift
//  CPUSimulator
//
//  Created by Alic on 2016-08-07.
//  Copyright © 2016 4ZC3. All rights reserved.
//

import UIKit

class CPUViewController: UIViewController {
    
    //Constants
    private let INSTR_DRAGGABLE_ORIGIN = CGPoint(x: 900, y: 50)
    
    // variables for draggables
    private var selectedView:UIViewWrapper?
    private var dragOrigin = CGPoint()
    
    private var targetView: UIViewWrapper?
    
    private var gameState: State = State.Null {
        willSet{
            print("=== will set `state` to \(newValue)")
        }
        didSet{
            print("=== did set `state`")
            if gameState == State.SuccessDrag {
                nextLevel()
            }
        }
    }
    
    // views and controllers
    private var registerBlockView = RegisterBlockView(frame: CGRect(x: 450, y: 700, width: 560, height: 240))
    private var aluView = ALUView(frame: CGRect(x: 450, y: (700 + 240), width: 560, height: 240))
    private var memoryBlockView = MemoryBlockView(frame: CGRect(x: 50, y: (700-2*240), width: 240, height: 940))
    private var instructionBlockController = InstructionBlockController()
    
    override func viewDidLoad() {
        // Do any additional setup after loading the view, typically from a nib.
        super.viewDidLoad()
        addInstructionViewController()
        
        self.view.addSubview(registerBlockView)
        self.view.addSubview(aluView)
        self.view.addSubview(memoryBlockView)
        
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
            selectedView = self.view.hitTest(p, withEvent: nil) as? UIViewWrapper
            
            if let subview = selectedView as? DraggableView {
                print("selected")
                self.view.bringSubviewToFront(subview)
                dragOrigin = subview.lastLocation
            }
            
        case .Changed:
            if let subview = selectedView as? DraggableView {
                subview.center = p
            }
        case .Ended:
            if let subview = selectedView as? DraggableView {
                // start validating drag result
                if subview.frame.intersects(self.view.convertRect(targetView!.frame, fromView: targetView!.superview)) {
                    if gameState == State.WaitForDrag {
                        subview.removeFromSuperview()
                        targetView!.value = subview.value
                        gameState = State.SuccessDrag
                    }
                }else{
                    subview.center = dragOrigin
                }
                
            }
            selectedView = nil
        default:
            selectedView = nil
        }
    }
    
    func processInstruction(){
        let instr = instructionBlockController.getCurrentInstruction()
        print(instr)
        
        switch instr {
        case let .Load           (rg1, rg2, rg3):
            return
        case let .Store          (rg1, rg2, rg3):
            return
        case let .LoadImmediate  (rg, val):
            createDraggable(INSTR_DRAGGABLE_ORIGIN, value: String(val))
            targetView = registerBlockView.getRegView(regNum: rg)
            targetView!.layer.borderColor = UIColor.blueColor().CGColor
            targetView!.layer.borderWidth = 5
            
            self.view.bringSubviewToFront(targetView!)
            gameState = State.WaitForDrag
            return
        case let .Add            (rg1, rg2, rg3):
            return
        case let .Multiply       (rg1, rg2, rg3):
            return
        case let .And            (rg1, rg2, rg3):
            return
        case let .Or             (rg1, rg2, rg3):
            return
        case let .Not            (rg1, rg2, rg3):
            return
        case let .Rotate         (rg1, rg2, val):
            return
        case let .Compare        (rg1, rg2):
            return
        case let .Branch         (_, rg1): //FIXME
            return
        case .Halt:
            nextLevel()
            return
        }
        
    }
    
    private func validateInstruction(subview: UIView){
        
    }
    
    private func createDraggable(origin: CGPoint, value: String) {
        let draggable = DraggableView(frame: CGRect(origin: origin, size: DraggableView.SIZE))
        draggable.value = value;
        self.view.addSubview(draggable)
    }
    
    private func nextLevel() {
        cleanViews()
        instructionBlockController.nextStage()
        processInstruction()
    }
    
    private func cleanViews() {
        if targetView != nil {
            targetView!.layer.borderColor = UIColor.blackColor().CGColor
            targetView!.layer.borderWidth = 1
        }
        targetView = nil
        selectedView = nil
    }
    
}
