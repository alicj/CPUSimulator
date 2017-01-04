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
    private var draggableCount = 0 // may not be useful
    
    //    private var targetView: UIViewWrapper?
    private var currentTargets: [UIViewWrapper] = []
    private var pendingTargets: [UIViewWrapper] = []
    
    
    private var gameState: State = State.Null {
        willSet{
            //            print("=== will set `state` to \(newValue)")
        }
        didSet{
            //            print("=== did set `state`")
            switch gameState {
            case State.GameStart:
                processInstruction()
                return
                
            case State.SuccessDragRegister:
                nextLevel()
                return
                
            case State.SuccessDragCalc:
                processCalculation()
                processInstruction()
                return
                
            default:
                return
            }
        }
    }
    
    // views and controllers
    private var registerBlockView = RegisterBlockView(frame: CGRect(x: 450, y: 600, width: 560, height: 240))
    private var aluView = ALUView(frame: CGRect(x: 450, y: (600 + 240), width: 560, height: 360))
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
        
        gameState = State.GameStart
        
        //debug
        let tap = UITapGestureRecognizer(target: self, action: #selector(CPUViewController.showMoreActions(_:)))
        tap.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap)
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
    
    //debug
    func showMoreActions(touch: UITapGestureRecognizer) {
        
        let touchPoint = touch.locationInView(self.view)
        print (touchPoint)
        
    }
    
    
    @objc private func pan(rec:UIPanGestureRecognizer) {
        let p:CGPoint = rec.locationInView(self.view)
        
        switch rec.state {
        case .Began:
            selectedView = self.view.hitTest(p, withEvent: nil) as? UIViewWrapper
            
            if let subview = selectedView as? DraggableView {
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
                var hit = false
                
                for (i, targetView) in currentTargets.enumerate() {
                    
                    let targetRect = self.view.convertRect(targetView.frame, fromView: targetView.superview)
                    print("target frame: \(targetRect)")
                    print("subview frame: \(subview.frame)")
                    
                    if subview.frame.intersects(targetRect) {
                        switch gameState {
                            
                        case .WaitForDragResult,
                             .WaitForDragRegister:
                            hit = true
                            subview.removeFromSuperview()
                            targetView.value = subview.value
                            gameState = State.SuccessDragRegister
                            return
                            
                        case .WaitForDragCalc:
                            if targetView is OperandView {
                                if subview.property == "Operand" {
                                    hit = true
                                    subview.removeFromSuperview()
                                    targetView.value = subview.value
                                    currentTargets.removeAtIndex(i)
                                }
                            }else {
                                if subview.property == "Operator" {
                                    hit = true
                                    subview.removeFromSuperview()
                                    targetView.value = subview.value
                                    currentTargets.removeAtIndex(i)
                                    
                                }
                            }
                            
                            if currentTargets.count == 0 {
                                gameState = State.SuccessDragCalc
                            }
                            return
                            
                        default:
                            return
                        }
                        
                    }
                }
                
                if !hit {
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
            
        case let .LoadImmediate  (rg, val):
            createDraggable(INSTR_DRAGGABLE_ORIGIN, value: String(val), property: "Register")
            draggableCount = 1;
            currentTargets.append(registerBlockView.getRegView(regNum: rg))
            
            //            self.view.bringSubviewToFront(targetView!)
            gameState = State.WaitForDragRegister
            return
            
        case let .Add            (rg1, rg2, rg3):
            if gameState != State.SuccessDragCalc {
                let operand1 = registerBlockView.getRegView(regNum: rg2)
                let operand2 = registerBlockView.getRegView(regNum: rg3)
                
                createDraggable(convertRect(operand1).origin, value: operand1.value, property: "Operand")
                createDraggable(convertRect(operand2).origin, value: operand2.value, property: "Operand")
                createDraggable(CGPoint(x: 600, y:1100), value: "+", property: "Operator")
                
                currentTargets.append(aluView.getOperandView(0))
                currentTargets.append(aluView.getOperandView(1))
                currentTargets.append(aluView.getOperatorView())
                pendingTargets.append(registerBlockView.getRegView(regNum: rg1))
                
                gameState = State.WaitForDragCalc
                
            }else{
                let resultView = aluView.getResultView()
                createDraggable(convertRect(resultView).origin, value: resultView.value, property: "Register")
                
                currentTargets.append(registerBlockView.getRegView(regNum: rg1))
                gameState = State.WaitForDragResult
            }
            return
            
            //        case let .Multiply       (rg1, rg2, rg3):
            //            return
            //        case let .And            (rg1, rg2, rg3):
            //            return
            //        case let .Or             (rg1, rg2, rg3):
            //            return
            //        case let .Not            (rg1, rg2, rg3):
            //            return
            //
            //        case let .Load           (rg1, rg2, rg3):
            //            return
            //        case let .Store          (rg1, rg2, rg3):
            //            return
            //        case let .Rotate         (rg1, rg2, val):
            //            return
            //        case let .Compare        (rg1, rg2):
            //            return
            //        case let .Branch         (_, rg1): //FIXME
        //            return
        case .Halt:
            nextLevel()
            return
            
        default:
            return
        }
        
    }
    
    func processCalculation() {
        let resultView = aluView.getResultView()
        
        switch aluView.getOperatorView().value {
        case "+":
            resultView.value = String(Int(aluView.getOperandView(0).value)! + Int(aluView.getOperandView(1).value)!)
        default:
            return
        }
        
        
        
    }
    
    private func validateInstruction(subview: UIView){
        
    }
    
    private func createDraggable(origin: CGPoint, value: String, property: String) {
        let draggable = DraggableView(frame: CGRect(origin: origin, size: DraggableView.SIZE))
        draggable.value = value
        draggable.property = property
        self.view.addSubview(draggable)
        draggableCount += 1
    }
    
    
    private func nextLevel() {
        cleanViews()
        instructionBlockController.nextStage()
        processInstruction()
    }
    
    private func cleanViews() {
        currentTargets = []
        pendingTargets = []
        selectedView = nil
        draggableCount = 0
    }
    
    private func convertRect(view : UIView) -> CGRect {
        return self.view.convertRect(view.frame, fromView: view.superview)
    }
}
