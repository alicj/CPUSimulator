//
//  CPUViewController.swift
//  CPUSimulator
//
//  Created by Alic on 2016-08-07.
//  Copyright © 2016 4ZC3. All rights reserved.
//

import UIKit

class CPUViewController: UIViewController, InstructionBlockDelegate, MemoryBlockDelegate {
    
    // variables for draggables
    fileprivate var selectedView:UIViewWrapper?
    fileprivate var dragOrigin = CGPoint()
    
    //    private var targetView: UIViewWrapper?
    fileprivate var currentTargets: [UIViewWrapper] = []
    fileprivate var pendingTargets: [UIViewWrapper] = []
    fileprivate var draggables: [DraggableView] = []
    
    fileprivate let memory: Memory = Memory(count: Int(pow(2.0, 5.0)))
    
    // views and controllers
    fileprivate var instructionBlockController = InstructionBlockController()
    
    fileprivate var registerBlockView = RegisterBlockView(frame: Sizes.registerBlock.frame)
    fileprivate var aluBlockView = ALUBlockView(frame: Sizes.ALUBlock.frame)
    //    fileprivate var memoryBlockView = MemoryBlockView(frame: CGRect(x: 50, y: (700-2*240), width: 240, height: 940))
    fileprivate var memoryController = MemoryBlockController(style: UITableViewStyle.plain)
    
    fileprivate var gameState: State = State.null {
        didSet{
            print("gameState didSet to \(gameState)")
            switch gameState {
            case State.gameStart:
                processInstruction()
                
            case State.successLoadImmediate,
                 State.successDragCalcResult,
                 State.successBranch,
                 State.successLoad,
                 State.successStore:
                if oldValue == State.waitForDragCalcResult {
                    cleanALUViews()
                }
                nextLevel()
                
            case State.successDragOperands:
                processCalculation()
                processInstruction()
                
            default:
                return
            }
        }
    }
    
    override func viewDidLoad() {
        // Do any additional setup after loading the view, typically from a nib.
        super.viewDidLoad()
        
        addControllers()
        
        self.view.addSubview(registerBlockView)
        self.view.addSubview(aluBlockView)
        
        //        registerBlockView.translatesAutoresizingMaskIntoConstraints = false
        //        let registerConstraint = NSLayoutConstraint(item: registerBlockView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 28)
        //        self.view.addConstraints([registerConstraint])
        
        //        self.view.addSubview(aluBlockView)
        //        self.view.addSubview(memoryBlockView)
        
        aluBlockView.backgroundColor = Sizes.debugColor
        
        setupGestures()
        
        gameState = State.gameStart
        
        //debug
        let tap = UITapGestureRecognizer(target: self, action: #selector(CPUViewController.printTouchPoint(_:)))
        tap.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
    
    fileprivate func addControllers() {
        addChildViewController(instructionBlockController)
        addChildViewController(memoryController)
        
        self.view.addSubview(instructionBlockController.view)
        self.view.addSubview(memoryController.tableView!)
        
        instructionBlockController.delegate = self
        memoryController.delegate = self
        memoryController.setMemory(memory: memory)
        
        for childViewController in childViewControllers {
            childViewController.didMove(toParentViewController: self)
        }
    }
    
    fileprivate func setupGestures() {
        let gesture = UIPanGestureRecognizer(target:self, action:#selector(pan(_:)))
        gesture.maximumNumberOfTouches = 1
        gesture.minimumNumberOfTouches = 1
        self.view.addGestureRecognizer(gesture)
    }
    
    //debug
    func printTouchPoint(_ touch: UITapGestureRecognizer) {
        
        let touchPoint = touch.location(in: self.view)
        print (touchPoint)
        
    }
    
    
    @objc fileprivate func pan(_ rec:UIPanGestureRecognizer) {
        let p:CGPoint = rec.location(in: self.view)
        
        switch rec.state {
        case .began:
            selectedView = self.view.hitTest(p, with: nil) as? UIViewWrapper
            if let draggedView = selectedView as? DraggableView {
                self.view.bringSubview(toFront: draggedView)
                dragOrigin = draggedView.lastLocation
            }
            
        case .changed:
            if let draggedView = selectedView as? DraggableView {
                draggedView.center = p
            }
        case .ended:
            if let draggedView = selectedView as? DraggableView {
                var hit = false
                
                for (i, targetView) in currentTargets.enumerated() {
                    
                    let targetRect = convertToSuperview(targetView)
                    
                    if draggedView.frame.intersects(targetRect) {
                        switch gameState {
                            
                        case .waitForDragCalcResult,
                             .waitForLoadImmediate:
                            hit = true
                            draggedView.removeFromSuperview()
                            targetView.value = draggedView.value
                            gameState = State.successDragCalcResult
                            
                        case .waitForDragOperands:
                            if let target = targetView as? OperandView {
                                if draggedView.type.range(of: "operand") != nil {
                                    if (draggedView.type == target.type) {
                                        hit = true
                                        draggedView.removeFromSuperview()
                                        targetView.value = draggedView.value
                                        currentTargets.remove(at: i)
                                    }
                                }
                            }else if draggedView.type == "operator" {
                                hit = true
                                draggedView.removeFromSuperview()
                                targetView.value = draggedView.value
                                currentTargets.remove(at: i)
                                
                            }
                            
                            if currentTargets.count == 0 {
                                gameState = State.successDragOperands
                            }
                            
                        case .waitForStore:
                            memory.set(pointer: Int(targetView.value)!, value: Int(draggedView.value)!)
                            memoryController.tableView.reloadData()
                            draggedView.removeFromSuperview()
                            gameState = State.successStore
                            
                        case .waitForLoad:
                            return
                            
                        default:
                            return
                        }
                    }
                }
                
                if !hit {
                    draggedView.center = dragOrigin
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
            createDraggable(origin: Sizes.draggable.originForInstruction, offset: CGPoint.zero, value: String(val), type: "register")
            currentTargets.append(registerBlockView.getRegView(regNum: rg))
            gameState = State.waitForLoadImmediate
            
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
            
        case let .load           (rg1, rg2):
            registerBlockView.getRegView(regNum: rg1).value = String(memory.get(pointer: Int(registerBlockView.getRegView(regNum: rg2).value)!))
            nextLevel()
            return
            
        case let .store          (rg1, rg2):
            processStore(toMemory: rg1, fromRegister: rg2)
            
        case let .compare        (rg1, rg2):
            processCalcInstr("Compare", [8, rg1, rg2])
            
        case let .branch         (condition, rg1):
            processBranch(condition, rg1)
            
        case .halt:
            nextLevel()
            
        }
        
    }
    
    fileprivate func processCalcInstr(_ operation : String, _ values: [Int]) {
        // generate draggables for operands and operator
        if gameState != State.successDragOperands {
            let operand1 = registerBlockView.getRegView(regNum: values[1])
            
            createDraggable(origin: convertToSuperview(operand1).origin, offset: Sizes.draggable.offsetForRegister, value: operand1.value, type: "operand1")
            createDraggable(origin: Sizes.draggable.originForOperator, offset: CGPoint.zero, value: operation, type: "operator")
            
            currentTargets.append(aluBlockView.getOperandView(0))
            currentTargets.append(aluBlockView.getOperatorView())
            
            pendingTargets.append(registerBlockView.getRegView(regNum: values[0]))
            
            if values.count > 2 {
                let operand2 = registerBlockView.getRegView(regNum: values[2])
                
                createDraggable(origin: convertToSuperview(operand2).origin, offset: Sizes.draggable.offsetForRegister, value: operand2.value, type: "operand2")
                
                currentTargets.append(aluBlockView.getOperandView(1))
            }
            
            gameState = State.waitForDragOperands
            
        }
            // generate draggables for calculaiton result
        else{
            let resultView = aluBlockView.getResultView()
            createDraggable(origin: convertToSuperview(resultView).origin, offset: CGPoint.zero, value: resultView.value, type: "register")
            
            currentTargets.append(registerBlockView.getRegView(regNum: values[0]))
            gameState = State.waitForDragCalcResult
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
    
    fileprivate func processBranch(_ condition: String, _ jumpTo: Int) {
        instructionBlockController.enableScrolling()
        instructionBlockController.jumpTo = jumpTo
    }
    
    fileprivate func processLoad() {
        
    }
    
    fileprivate func processStore(toMemory destination: Int, fromRegister origin: Int) {
        gameState = State.waitForStore
        
        let address = Int(registerBlockView.getRegView(regNum: destination).value)!
        let sourceRegister = registerBlockView.getRegView(regNum: origin)
        
        createDraggable(origin: convertToSuperview(sourceRegister).origin, offset: Sizes.draggable.offsetForRegister, value: sourceRegister.value, type: "register")
        
        // only do the following if cell is visible
        let targetCell = memoryController.tableView.cellForRow(at: IndexPath(row: address, section: 0))
        
        if (targetCell == nil) {
            return
        }
        
        let targetView = UIViewWrapper(frame: convertToSuperview(targetCell!))
        targetView.value = String(address)
        
        currentTargets.append(targetView)
    }
    
    internal func onSuccessBranch() {
        gameState = State.successBranch
    }
    
    internal func onMemoryScroll() {
        if (gameState == State.waitForStore || gameState == State.waitForLoad) {
            for targetView in currentTargets {
                targetView.removeFromSuperview()
            }
            for draggable in draggables {
                draggable.removeFromSuperview()
            }
        }
    }
    
    internal func endMemoryScroll() {
        print("end memory scroll")
        if (gameState == State.waitForStore || gameState == State.waitForLoad) {
            processInstruction()
        }
    }
    
    // consider takign a view instead of origin, and do the convert + get origin inside
    fileprivate func createDraggable(origin: CGPoint, offset: CGPoint, value: String, type: String) {
        print ("creating draggable \(type) with value \(value)")
        let newOrigin = CGPoint(x: origin.x + offset.x, y: origin.y + offset.y)
        let draggable = DraggableView(frame: CGRect(origin: newOrigin, size: Sizes.draggable.size))
        draggable.value = value
        draggable.type = type
        
        let size = (value as NSString).size(attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: Sizes.draggable.font)])
        if size.width > draggable.bounds.width {
            draggable.setFontSize(size: Sizes.font.medium)
        }
        draggables.append(draggable)
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
        draggables = []
        selectedView = nil
    }
    
    fileprivate func convertToSuperview(_ view : UIView) -> CGRect {
        return self.view.convert(view.frame, from: view.superview)
    }
}
