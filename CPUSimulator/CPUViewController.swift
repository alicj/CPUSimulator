//
//  CPUViewController.swift
//  CPUSimulator
//
//  Created by Alic on 2016-08-07.
//  Copyright © 2016 4ZC3. All rights reserved.
//

import UIKit

class CPUViewController: UIViewController, InstructionBlockDelegate, MemoryBlockDelegate, PathDelegate {
    
    // variables for draggables
    fileprivate var selectedView:UIViewWrapper?
    fileprivate var dragOrigin = CGPoint()
    
    fileprivate var currentTargets: [UIViewWrapper] = []
    fileprivate var lastTargetView: UIViewWrapper?
    fileprivate var draggables: [DraggableView] = []
    fileprivate var hintMessage: UILabel = UILabel(frame: Sizes.hintMessage.frame)
    fileprivate var timer: Timer = Timer()
    fileprivate var colourCount: Double = 0
    
    fileprivate let memory: Memory = Memory(count: pow(2.0, 5.0))
    
    // views and controllers
    fileprivate var instructionBlockController = InstructionBlockController()
    fileprivate var registerBlockView = RegisterBlockView(frame: Sizes.registerBlock.frame)
    fileprivate var aluBlockView = ALUBlockView(frame: Sizes.ALUBlock.frame)
    fileprivate var memoryController = MemoryBlockController(style: UITableViewStyle.plain)
    fileprivate var pathController = PathController()
    
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
        super.viewDidLoad()
        
        addControllers()
        addViews()
        
        //        registerBlockView.translatesAutoresizingMaskIntoConstraints = false
        //        let registerConstraint = NSLayoutConstraint(item: registerBlockView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 28)
        //        self.view.addConstraints([registerConstraint])
        
        self.view.backgroundColor = Sizes.debugColor
        
        setupGestures()
        
        gameState = State.gameStart
        
        //debug
        let tap = UITapGestureRecognizer(target: self, action: #selector(CPUViewController.printTouchPoint(touch:)))
        tap.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
    
    // MemoryBlockDelegate
    // clean up draggables when scrolling memory table
    internal func onMemoryScroll() {
        if gameState == State.waitForStore || gameState == State.waitForLoad {
            cleanUp()
        }
    }
    
    // generate draggables when finished scrolling memory table
    internal func endMemoryScroll() {
        if gameState == State.waitForStore || gameState == State.waitForLoad {
            processInstruction()
        }
    }
    
    //PathDelegate
    internal func updateTargetView(nthDigit: Int, withValue: String) {
        print("update target \(nthDigit)th digit with value \(withValue)")
        if lastTargetView != nil {
            if withValue == "1" {
                let n = Double(lastTargetView!.value)! + pow(2, Double(nthDigit))
                lastTargetView?.value = String(n)
            }
        }
    }
    
    
    fileprivate func addControllers() {
        addChildViewController(instructionBlockController)
        addChildViewController(memoryController)
        addChildViewController(pathController)
        
        
        instructionBlockController.delegate = self
        memoryController.delegate = self
        memoryController.setMemory(memory: memory)
        pathController.delegate = self
        
        for childViewController in childViewControllers {
            childViewController.didMove(toParentViewController: self)
        }
    }
    
    fileprivate func addViews() {
        self.view.addSubview(pathController.view)
        
        self.view.addSubview(instructionBlockController.view)
        self.view.addSubview(registerBlockView)
        self.view.addSubview(aluBlockView)
        self.view.addSubview(memoryController.tableView!)
        view.addSubview(hintMessage);
        
        registerBlockView.layer.borderWidth = 1
        aluBlockView.layer.borderWidth = 1
        aluBlockView.backgroundColor = Sizes.debugColor
        
        hintMessage.numberOfLines = 0
        
    }
    
    fileprivate func setupGestures() {
        let gesture = UIPanGestureRecognizer(target:self, action:#selector(pan(rec:)))
        gesture.maximumNumberOfTouches = 1
        gesture.minimumNumberOfTouches = 1
        self.view.addGestureRecognizer(gesture)
    }
    
    //debug function
    func printTouchPoint(touch: UITapGestureRecognizer) {
//        pathController.animate(pathKey: "instructionBlockToRegisterBlock", digits: "100001110")

        let touchPoint = touch.location(in: self.view)
        print (touchPoint)
    }
    
    @objc fileprivate func pan(rec:UIPanGestureRecognizer) {
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
                    lastTargetView = targetView
                    let targetRect = convertToSuperview(targetView)
                    
                    if draggedView.frame.intersects(targetRect) {
                        switch gameState {
                            
                        case .waitForDragCalcResult:
                            hit = true
                            draggedView.removeFromSuperview()
                            targetView.value = draggedView.value
                            gameState = State.successDragCalcResult
                        
                        case .waitForLoadImmediate:
                            hit = true
                            draggedView.removeFromSuperview()
                            targetView.value = draggedView.value
                            gameState = State.successDragCalcResult
                            let bin = Binary.twosComplement(num: Int16(draggedView.value)!)
                            pathController.animate(pathKey: "instructionBlockToRegisterBlock", digits: bin)
                            
                        case .waitForDragOperands:
                            if let target = targetView as? OperandView {
                                if draggedView.type == .operand1 || draggedView.type == .operand2 {
                                    if draggedView.type == target.type {
                                        hit = true
                                        draggedView.removeFromSuperview()
                                        targetView.value = draggedView.value
                                        currentTargets.remove(at: i)
                                    }
                                }
                            }else if draggedView.type == .operator {
                                hit = true
                                draggedView.removeFromSuperview()
                                targetView.value = draggedView.value
                                currentTargets.remove(at: i)
                                
                            }
                            
                            if currentTargets.count == 0 {
                                gameState = State.successDragOperands
                            }
                            
                        case .waitForStore:
                            memory.set(address: Int(targetView.value)!, value: Int(draggedView.value)!)
                            memoryController.tableView.reloadData()
                            draggedView.removeFromSuperview()
                            gameState = State.successStore
                            
                        case .waitForLoad:
                            targetView.value = draggedView.value
                            draggedView.removeFromSuperview()
                            gameState = State.successLoad
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
        if let instr = instructionBlockController.getCurrentInstruction() {
            switch instr {
                
            case let .loadImmediate  (rg, val):
                createDraggable(origin: Sizes.draggable.originForInstruction, offset: CGPoint.zero, value: String(val), type: .register)
                // create TargetView here using the UIViewWrapper
                currentTargets.append(registerBlockView.getRegView(regNum: rg))
                gameState = State.waitForLoadImmediate
                
            case let .add            (rg1, rg2, rg3):
                processCalcInstr(operation: "+", values: [rg1, rg2, rg3])
                
            case let .multiply       (rg1, rg2, rg3):
                processCalcInstr(operation: "x", values: [rg1, rg2, rg3])
                
            case let .and            (rg1, rg2, rg3):
                processCalcInstr(operation: "And", values: [rg1, rg2, rg3])
                
            case let .or             (rg1, rg2, rg3):
                processCalcInstr(operation: "Or", values: [rg1, rg2, rg3])
                
            case let .rotate         (rg1, rg2, val):
                processCalcInstr(operation: "Rotate", values: [rg1, rg2, val])
                
            case let .not            (rg1, rg2):
                processCalcInstr(operation: "Not", values: [rg1, rg2])
                
            case let .load           (rg1, rg2):
                processLoadInstr(toRegister: rg1, fromMemory: rg2)
                
            case let .store          (rg1, rg2):
                processStoreInstr(toMemory: rg1, fromRegister: rg2)
                
            case let .compare        (rg1, rg2):
                processCalcInstr(operation: "Compare", values: [8, rg1, rg2])
                
            case let .branch         (condition, rg1):
                processBranchInstr(condition: condition, jumpTo: rg1)
                
            case .halt:
                nextLevel()
            }
        }
        else {
            return
        }
        
    }
    
    fileprivate func processCalcInstr(operation : String, values: [Int]) {
        // generate draggables for operands and operator
        if gameState != State.successDragOperands {
            let operand1 = registerBlockView.getRegView(regNum: values[1])
            
            createDraggable(origin: convertToSuperview(operand1).origin, offset: Sizes.draggable.offsetForRegister, value: operand1.value, type: .operand1)
            createDraggable(origin: Sizes.draggable.originForOperator, offset: CGPoint.zero, value: operation, type: .operator)
            
            currentTargets.append(aluBlockView.getOperandView(index: 0))
            currentTargets.append(aluBlockView.getOperatorView())

            if values.count > 2 {
                let operand2 = registerBlockView.getRegView(regNum: values[2])
                
                createDraggable(origin: convertToSuperview(operand2).origin, offset: Sizes.draggable.offsetForRegister, value: operand2.value, type: .operand2)
                
                currentTargets.append(aluBlockView.getOperandView(index: 1))
            }
            
            gameState = State.waitForDragOperands
            
        }
        // generate draggables for calculaiton result
        else{
            let resultView = aluBlockView.getResultView()
            createDraggable(origin: convertToSuperview(resultView).origin, offset: CGPoint.zero, value: resultView.value, type: .register)
            
            currentTargets.append(registerBlockView.getRegView(regNum: values[0]))
            gameState = State.waitForDragCalcResult
        }
    }
    
    fileprivate func processCalculation() {
        let resultView = aluBlockView.getResultView()
        let op = aluBlockView.getOperatorView().value
        
        let op1 = Int16(aluBlockView.getOperandView(index: 0).value)!
        var op2 = Int16()
        
        if !aluBlockView.getOperandView(index: 1).value.isEmpty {
            op2 = Int16(aluBlockView.getOperandView(index: 1).value)!
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
            if op1 > op2 {
                resultView.value = "GT"
            }
            else if op1 < op2 {
                resultView.value = "LT"
            }
            else {
                resultView.value = "EQ"
            }
        default:
            return
        }
    }
    
    fileprivate func processBranchInstr(condition: String, jumpTo: Int) {
        instructionBlockController.enableScrolling()
        instructionBlockController.jumpTo = Int(registerBlockView.getRegView(regNum: jumpTo).value)
        hintMessage.text = "Hint: scroll the instruction block to the correct position"
    }
    
    fileprivate func processLoadInstr(toRegister destination: Int, fromMemory origin: Int ) {
        gameState = State.waitForLoad
        
        let address = Int(registerBlockView.getRegView(regNum: origin).value)!
        let destRegister = registerBlockView.getRegView(regNum: destination)
        let targetCell = memoryController.tableView.cellForRow(at: IndexPath(row: address, section: 0))
        
        if targetCell == nil {
            // targetCell not in view
            return
        }
        
        createDraggable(origin: convertToSuperview(targetCell!).origin, offset: Sizes.draggable.offsetForMemory, value: String(memory.get(address: address)), type: .memory)
        
        currentTargets.append(destRegister)
    }
    
    fileprivate func processStoreInstr(toMemory destination: Int, fromRegister origin: Int) {
        gameState = State.waitForStore
        
        let address = Int(registerBlockView.getRegView(regNum: destination).value)!
        let sourceRegister = registerBlockView.getRegView(regNum: origin)
        let targetCell = memoryController.tableView.cellForRow(at: IndexPath(row: address, section: 0))
        
        if targetCell == nil {
            // targetCell not in view
            return
        }
        
        let targetView = UIViewWrapper(frame: convertToSuperview(targetCell!))
        targetView.value = String(address)
        
        createDraggable(origin: convertToSuperview(sourceRegister).origin, offset: Sizes.draggable.offsetForRegister, value: sourceRegister.value, type: .register)
        
        currentTargets.append(targetView)
    }
    
    internal func onSuccessBranch() {
        gameState = State.successBranch
    }
    
    fileprivate func createDraggable(origin: CGPoint, offset: CGPoint, value: String, type: ViewType) {
        let newOrigin = CGPoint(x: origin.x + offset.x, y: origin.y + offset.y)
        let draggable = DraggableView(frame: CGRect(origin: newOrigin, size: Sizes.draggable.size), value: value, type: type)
        
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
        aluBlockView.getOperandView(index: 0).value = ""
        aluBlockView.getOperandView(index: 1).value = ""
        aluBlockView.getOperatorView().value = ""
    }
    
    fileprivate func cleanUp() {
        currentTargets = []
        lastTargetView = nil
        for draggable in draggables {
            draggable.removeFromSuperview()
        }
        draggables = []
        selectedView = nil
        hintMessage.text = ""
    }
    
    fileprivate func convertToSuperview(_ view : UIView) -> CGRect {
        return self.view.convert(view.frame, from: view.superview)
    }
    
    internal func endGame() {
        hintMessage.text = "Congratulations, you have completed all levels!"
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector:#selector(CPUViewController.rainbowHint), userInfo: nil, repeats: true)
    }
    
    internal func rainbowHint(){
        self.hintMessage.textColor = Util.makeColorGradient(frequency1: 0.3, frequency2: 0.3, frequency3: 0.3, phase1: 0, phase2: 2, phase3: 4, len: colourCount)
        colourCount += 1;
        
        if colourCount > 1000 {
            timer.invalidate()
        }
    }
}
