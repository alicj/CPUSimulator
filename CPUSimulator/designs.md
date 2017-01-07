Design aspects of the app
--
###The views
Each `*BlockView` are the view classes for the big components of the main view. And the other views in their indivicual folders are basic views that the block view uses. `CPUViewController` is the main controller of the program. It loads all the block views onto the story board, and lets the user interact with them

(Side note, maybe we should have one main view  that loads all the block view, and have `CPUViewController` only load the main view. Or, we can set up controllers for each view, and only instantiate the controllers in `CPUViewController`, just like how we did with `InstructionBlockController`. Or the other way around, delete `InstructionBlockController` and move its content to the view instead)

###The basic of views
`UIViewWrapper` is the core class of the program. All the basic view classes inherit from `UIViewWrapper`, including `Draggable`, `Register`, `Operand`, and `Operater`. `UIViewWrapper` inherit from UIView, and adds one property, `value`: `String`, with its own getter and setter. The variable allows a easy way to access the text value of the `UILabel` inside the view. The wrapper inherit from `UIView` insetad of `UILabel` to accomadate `RegisterView`, as there are two `UILabel`s in `RegisterView`.

(Side note, maybe it's still better to have these basic views as `UILabel` (so separate the two labels within register), as in that way, the size of the label can be controlled in their parent views. Whereas now, an `UILabel` is created in side the basic views, and the basic views has to be created with the exact same dimension in their parents views, which adds complexity to the code. We'll evaluate the possibility of this in a later date.)

###GameState
Another important aspect of the program is the `gameState` variable in `CPUViewController`. It sotres the current state of the program, either that the program is waiting for user to perform a drag gesture, or a drag gesture is successfully performed. It is  changed when a success drag is performed, or when an instruction is setup (draggables and their targets are generated). When the value of `gameState` changes, it will call functions to move the program forward. For example, when all draggables are dropped onto the ALU block, the `gameState` will change, and upon change, it will process the calculation, and generated a new draggale for user to drop on a register. And when that action is performed, the change of `gameState` will call functions to go to the next instruction.

Program flows
--
The following is how the program should work with difference instruction, **bold** ones are in working state:

**Note**: targets are all put into an array, so when the array length becomes 0, user input has finished, and the state will be promoted

- `case let .Load           (rg1, rg2, rg3):`
    - generate a draggable on memeory location `rg2+rg3` with value of that memory block
    - validate draggable on envelop
    - generate draggable with value `rg1` on instruction block
    - validate draggable on envelop
    - animation to move envelop onto `rg1`
- `case let .Store          (rg1, rg2, rg3):`
    - generate a draggable with value at `rg1` on top of `rg1`
    - validate draggable on envelop
    - generate draggable with value `rg2+rg3` on instruction block
    - validate draggable on envelop
    - animation to move envelope onto memory location at `rg2+rg3`
- **`case let .LoadImmediate  (rg, val):`**
    - set up instruction
        + create draggable for the value, and target for the corresponding register
        + change `gameState` to `WaitForDragRegister`
    - wait for user input
        + when user input is valid, remove the draggable, and change `gameState` to `SuccessDragRegister`
    - upon `gameState` change, clean up variables and views, and process the next instruction
- **`case let .Add            (rg1, rg2, rg3):`**
- **`case let .Multiply       (rg1, rg2, rg3):`**
- **`case let .And            (rg1, rg2, rg3):`**
- **`case let .Or             (rg1, rg2):`**
- **`case let .Not            (rg1, rg2, rg3):`**
- **`case let .Rotate         (rg1, rg2, val):`**
    - All above cases are similar, except for the actual calculation, so they are using a uniform function with different parameters
    - set up instruction
        + generate draggables for the operator, `rg2`, and `rg3`/`val`, and their corresponding targets
        + change `gameState` to `WaitForDragCalc`
    - wait for user input
        + the operands has a strict order, `rg2` can only be the left one, and `rg3` can only be the right one
        + the operator can be dragged before, after, and between the operands
    - when all targets are hit, change `gameState` to `SuccessDragCalc`, which will do the calculation, create the draggable result, and its target at register `rg1`
        + and the user input part works the same as `WaitForDragRegister` from `LoadImmediate`
        + except upon completion, aside from processing the next instruction, the `ALUBlockView` will be cleaned up
- `case let .Compare        (rg1, rg2):`
    - 
- `case let .Branch         (_, rg1):`
    - 
- **`case .Halt:`**
    - call `nextLevel()`, which calls `cleanUp()` to clean up variables and views
    - call `instructionBlockController.nextStage()` for instruction block to display the next level
    - call `processInstruction()` to initiate the instruction