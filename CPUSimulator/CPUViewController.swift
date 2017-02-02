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
    fileprivate let INSTR_DRAGGABLE_ORIGIN = CGPoint(x: 900, y: 50)
    
    // variables for draggables
    fileprivate var selectedView:UIViewWrapper?
    fileprivate var dragOrigin = CGPoint()
    
    //    private var targetView: UIViewWrapper?
    fileprivate var currentTargets: [UIViewWrapper] = []
    fileprivate var pendingTargets: [UIViewWrapper] = []
    
    
    fileprivate var gameState: State = State.null {
        willSet{
            //            print("=== will set `state` to \(newValue)")
        }
        didSet{
            //            print("=== did set `state` to \(gameState)")
            switch gameState {
            case State.gameStart:
                processInstruction()
                
            case State.successDragRegister:
                if oldValue == State.waitForDragResult {
                    cleanALUViews()
                }
                nextLevel()
                
            case State.successDragCalc:
                processCalculation()
                processInstruction()
                
            default:
                return
            }
        }
    }
    
    // views and controllers
    fileprivate var registerBlockView = RegisterBlockView(frame: CGRect(x: 450, y: 600, width: 560, height: 240))
    fileprivate var aluBlockView = ALUBlockView(frame: CGRect(x: 450, y: (600 + 240), width: 560, height: 360))
    fileprivate var memoryBlockView = MemoryBlockView(frame: CGRect(x: 50, y: (700-2*240), width: 240, height: 940))
    fileprivate var instructionBlockController = InstructionBlockController()
    
    override func viewDidLoad() {
        // Do any additional setup after loading the view, typically from a nib.
        super.viewDidLoad()
                
        addInstructionViewController()
        
        self.view.addSubview(registerBlockView)
        self.view.addSubview(aluBlockView)
        self.view.addSubview(memoryBlockView)
        
        setupGestures()
        
        gameState = State.gameStart
        
        //debug
        let tap = UITapGestureRecognizer(target: self, action: #selector(CPUViewController.showMoreActions(_:)))
        tap.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
    
    fileprivate func addInstructionViewController() {
        addChildViewController(instructionBlockController)
        self.view.addSubview(instructionBlockController.view)
        instructionBlockController.didMove(toParentViewController: self)
    }
    
    fileprivate func setupGestures() {
        let gesture = UIPanGestureRecognizer(target:self, action:#selector(pan(_:)))
        gesture.maximumNumberOfTouches = 1
        gesture.minimumNumberOfTouches = 1
        self.view.addGestureRecognizer(gesture)
    }
    
    //debug
    func showMoreActions(_ touch: UITapGestureRecognizer) {
        
        let touchPoint = touch.location(in: self.view)
        print (touchPoint)
        
    }
    
    
    @objc fileprivate func pan(_ rec:UIPanGestureRecognizer) {
        let p:CGPoint = rec.location(in: self.view)
        
        switch rec.state {
        case .began:
            selectedView = self.view.hitTest(p, with: nil) as? UIViewWrapper
            
            if let subview = selectedView as? DraggableView {
                self.view.bringSubview(toFront: subview)
                dragOrigin = subview.lastLocation
            }
            
        case .changed:
            if let subview = selectedView as? DraggableView {
                subview.center = p
            }
        case .ended:
            if let subview = selectedView as? DraggableView {
                var hit = false
                
                for (i, targetView) in currentTargets.enumerated() {
                    
                    let targetRect = self.view.convert(targetView.frame, from: targetView.superview)
                    
                    if subview.frame.intersects(targetRect) {
                        switch gameState {
                            
                        case .waitForDragResult,
                             .waitForDragRegister:
                            hit = true
                            subview.removeFromSuperview()
                            targetView.value = subview.value
                            gameState = State.successDragRegister
                            
                        case .waitForDragCalc:
                            if let target = targetView as? OperandView {
                                if subview.property.range(of: "Operand") != nil {
                                    if (subview.property == target.order) {
                                        hit = true
                                        subview.removeFromSuperview()
                                        targetView.value = subview.value
                                        currentTargets.remove(at: i)
                                    }
                                }
                            }else {
                                if subview.property == "Operator" {
                                    hit = true
                                    subview.removeFromSuperview()
                                    targetView.value = subview.value
                                    currentTargets.remove(at: i)
                                }
                            }
                            
                            if currentTargets.count == 0 {
                                gameState = State.successDragCalc
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
    
    fileprivate func processInstruction(){
        let instr = instructionBlockController.getCurrentInstruction()
        
        switch instr {
            
        case let .loadImmediate  (rg, val):
            createDraggable(INSTR_DRAGGABLE_ORIGIN, value: String(val), property: "Register")
            currentTargets.append(registerBlockView.getRegView(regNum: rg))
            gameState = State.waitForDragRegister
            
        case let .add            (rg1, rg2, rg3):
            processCalcInstr("+", [rg1, rg2, rg3])
            
        case let .multiply       (rg1, rg2, rg3):
            processCalcInstr("x", [rg1, rg2, rg3])
            
        case let .and            (rg1, rg2, rg3):
            processCalcInstr("And", [rg1, rg2, rg3])
            
        case let .or             (rg1, rg2, rg3):
            processCalcInstr("Or", [rg1, rg2, rg3])
            
        case let .rotate         (rg1, rg2, val):
            processCalcInstr("Rotate", [rg1, rg2, val])
            
        case let .not            (rg1, rg2):
            processCalcInstr("Not", [rg1, rg2])
            
            //        case let .Load           (rg1, rg2, rg3):
            //            return
            //        case let .Store          (rg1, rg2, rg3):
        //            return
        case let .compare        (rg1, rg2):
            processCalcInstr("Compare", [8, rg1, rg2])
        case let .branch         (condition, rg1): //FIXME
            processCompare(condition, rg1)
        case .halt:
            nextLevel()
            
        default:
            return
        }
        
    }
    
    fileprivate func processCalcInstr(_ operation : String, _ values: [Int]) {
        if gameState != State.successDragCalc {
            let operand1 = registerBlockView.getRegView(regNum: values[1])
            
            createDraggable(convertRect(operand1).origin, value: operand1.value, property: "Operand1")
            createDraggable(CGPoint(x: 600, y:1100), value: operation, property: "Operator")
            
            currentTargets.append(aluBlockView.getOperandView(0))
            currentTargets.append(aluBlockView.getOperatorView())
            
            pendingTargets.append(registerBlockView.getRegView(regNum: values[0]))
            
            if values.count > 2 {
                let operand2 = registerBlockView.getRegView(regNum: values[2])
                createDraggable(convertRect(operand2).origin, value: operand2.value, property: "Operand2")
                currentTargets.append(aluBlockView.getOperandView(1))
            }
            
            gameState = State.waitForDragCalc
            
        }else{
            let resultView = aluBlockView.getResultView()
            createDraggable(convertRect(resultView).origin, value: resultView.value, property: "Register")
            
            currentTargets.append(registerBlockView.getRegView(regNum: values[0]))
            gameState = State.waitForDragResult
        }
    }
    
    fileprivate func processCalculation() {
        let resultView = aluBlockView.getResultView()
        let op = aluBlockView.getOperatorView().value
        
        let op1 = UInt8(aluBlockView.getOperandView(0).value)!
        var op2 = UInt8()
        
        if !aluBlockView.getOperandView(1).value.isEmpty {
            op2 = UInt8(aluBlockView.getOperandView(1).value)!
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
        case "Compare":
            if (op1 > op2) {
                resultView.value = "GT"
            }
            else if (op1 < op2){
                resultView.value = "LT"
            }
            else {
                resultView.value = "EQ"
            }
        default:
            return
        }
    }
    
    fileprivate func processCompare(_ condition: String, _ programCounter: Int) {
        instructionBlockController.enableScrolling();
    }
    
    
    fileprivate func createDraggable(_ origin: CGPoint, value: String, property: String) {
        let draggable = DraggableView(frame: CGRect(origin: origin, size: DraggableView.SIZE))
        draggable.value = value
        draggable.property = property
        self.view.addSubview(draggable)
    }
    
    
    fileprivate func nextLevel() {
        cleanUp()
        instructionBlockController.nextStage()
        processInstruction()
    }
    
    fileprivate func cleanALUViews() {
        aluBlockView.getResultView().value = ""
        aluBlockView.getOperandView(0).value = ""
        aluBlockView.getOperandView(1).value = ""
        aluBlockView.getOperatorView().value = ""
    }
    
    fileprivate func cleanUp() {
        currentTargets = []
        pendingTargets = []
        selectedView = nil
    }
    
    
    
    fileprivate func convertRect(_ view : UIView) -> CGRect {
        return self.view.convert(view.frame, from: view.superview)
    }
}
