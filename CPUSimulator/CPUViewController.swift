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
    
    //    private var targetView: UIViewWrapper?
    private var currentTargets: [UIViewWrapper] = []
    private var pendingTargets: [UIViewWrapper] = []
    
    
    private var gameState: State = State.Null {
        willSet{
            //            print("=== will set `state` to \(newValue)")
        }
        didSet{
//            print("=== did set `state` to \(gameState)")
            switch gameState {
            case State.GameStart:
                processInstruction()
                
            case State.SuccessDragRegister:
                if oldValue == State.WaitForDragResult {
                    cleanALUViews()
                }
                nextLevel()
                
            case State.SuccessDragCalc:
                processCalculation()
                processInstruction()
                
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
                var hit = false
                
                for (i, targetView) in currentTargets.enumerate() {
                    
                    let targetRect = self.view.convertRect(targetView.frame, fromView: targetView.superview)
                    
                    if subview.frame.intersects(targetRect) {
                        switch gameState {
                            
                        case .WaitForDragResult,
                             .WaitForDragRegister:
                            hit = true
                            subview.removeFromSuperview()
                            targetView.value = subview.value
                            gameState = State.SuccessDragRegister
                            
                        case .WaitForDragCalc:
                            if let target = targetView as? OperandView {
                                if subview.property.rangeOfString("Operand") != nil {
                                    if (subview.property == target.order) {
                                        hit = true
                                        subview.removeFromSuperview()
                                        targetView.value = subview.value
                                        currentTargets.removeAtIndex(i)
                                    }
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
        
        switch instr {
            
        case let .LoadImmediate  (rg, val):
            createDraggable(INSTR_DRAGGABLE_ORIGIN, value: String(val), property: "Register")
            currentTargets.append(registerBlockView.getRegView(regNum: rg))
            
            gameState = State.WaitForDragRegister
            
        case let .Add            (rg1, rg2, rg3):
            processCalcInstr("+", values: [rg1, rg2, rg3])
            
        case let .Multiply       (rg1, rg2, rg3):
            processCalcInstr("x", values: [rg1, rg2, rg3])

        case let .And            (rg1, rg2, rg3):
            processCalcInstr("And", values: [rg1, rg2, rg3])

        case let .Or             (rg1, rg2, rg3):
            processCalcInstr("Or", values: [rg1, rg2, rg3])

        case let .Rotate         (rg1, rg2, val):
            processCalcInstr("Rotate", values: [rg1, rg2, val])

        case let .Not            (rg1, rg2):
            processCalcInstr("Not", values: [rg1, rg2])
            
            //        case let .Load           (rg1, rg2, rg3):
            //            return
            //        case let .Store          (rg1, rg2, rg3):
            //            return
            //        case let .Compare        (rg1, rg2):
            //            return
            //        case let .Branch         (_, rg1): //FIXME
        //            return
        case .Halt:
            nextLevel()
            
        default:
            return
        }
        
    }

    func processCalcInstr(operation : String, values: [Int]) {
        if gameState != State.SuccessDragCalc {
            let operand1 = registerBlockView.getRegView(regNum: values[1])
            
            createDraggable(convertRect(operand1).origin, value: operand1.value, property: "Operand1")
            createDraggable(CGPoint(x: 600, y:1100), value: operation, property: "Operator")
            
            currentTargets.append(aluView.getOperandView(0))
            currentTargets.append(aluView.getOperatorView())
            
            pendingTargets.append(registerBlockView.getRegView(regNum: values[0]))
            
            if values.count > 2 {
                let operand2 = registerBlockView.getRegView(regNum: values[2])
                createDraggable(convertRect(operand2).origin, value: operand2.value, property: "Operand2")
                currentTargets.append(aluView.getOperandView(1))
            }
            
            gameState = State.WaitForDragCalc
            
        }else{
            let resultView = aluView.getResultView()
            createDraggable(convertRect(resultView).origin, value: resultView.value, property: "Register")
            
            currentTargets.append(registerBlockView.getRegView(regNum: values[0]))
            gameState = State.WaitForDragResult
        }
    }
    
    func processCalculation() {
        let resultView = aluView.getResultView()
        let op = aluView.getOperatorView().value

        let op1 = UInt8(aluView.getOperandView(0).value)!
        var op2 = UInt8()
        
        if !aluView.getOperandView(1).value.isEmpty {
            op2 = UInt8(aluView.getOperandView(1).value)!
        }
        
        
        switch op {
        case "+":
            resultView.value = String(op1 + op2)
        case "x":
            resultView.value = String(op1 * op2)
        case "And":
            resultView.value = String(op1 & op2)
        case "Or":
            resultView.value = String(op1 | op2)
        case "Not":
            resultView.value = String(~op1)
        case "Rotate":
            if op2 > 0 {
                resultView.value = String(op1 << op2)
            }else {
                resultView.value = String(op1 >> op2)
            }
        default:
            return
        }
    }
    
    
    private func createDraggable(origin: CGPoint, value: String, property: String) {
        let draggable = DraggableView(frame: CGRect(origin: origin, size: DraggableView.SIZE))
        draggable.value = value
        draggable.property = property
        self.view.addSubview(draggable)
    }
    
    
    private func nextLevel() {
        cleanUp()
        instructionBlockController.nextStage()
        processInstruction()
    }
    
    private func cleanVariables() {
        currentTargets = []
        pendingTargets = []
        selectedView = nil
    }
    
    private func cleanALUViews() {
        aluView.getResultView().value = ""
        aluView.getOperandView(0).value = ""
        aluView.getOperandView(1).value = ""
        aluView.getOperatorView().value = ""
    }
    
    private func cleanUp() {
        cleanVariables()
    }
    
    
    
    private func convertRect(view : UIView) -> CGRect {
        return self.view.convertRect(view.frame, fromView: view.superview)
    }
}
