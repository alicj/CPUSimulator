I should set up a variable to store the state of the app. And it will act accordingly to its value

switch instr {
case let .Load           (rg1, rg2, rg3):
    - generate a draggable on memeory location `rg2+rg3` with value of that memory block
    - validate draggable on envelop
    - generate draggable with value `rg1` on instruction block
    - validate draggable on envelop
    - animation to move envelop onto `rg1`

case let .Store          (rg1, rg2, rg3):
    - generate a draggable with value at `rg1` on top of `rg1`
    - validate draggable on envelop
    - generate draggable with value `rg2+rg3` on instruction block
    - validate draggable on envelop
    - animation to move envelope onto memory location at `rg2+rg3`

case let .LoadImmediate  (rg, val):
    - generate draggable with value `val`
    - validate draggable on register `rg`

case let .Add            (rg1, rg2, rg3):
    - generate draggables with value at `rg2` and `rg3` on top of them
    - validate draggables on ALU computing blocks
    - generate draggable with value equals to the sum of `rg2` and `rg3` in ALU result block
    - validate draggable on `rg1`

case let .Multiply       (rg1, rg2, rg3):
    - generate draggables with value at `rg2` and `rg3` on top of them
    - validate draggables on ALU computing blocks
    - generate draggable with value equals to the sum of `rg2` and `rg3` in ALU result block
    - validate draggable on `rg1`

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
    return
}




switch instr {
case let .Load           (rg1, rg2, rg3):
return
case let .Store          (rg1, rg2, rg3):
return
case let .LoadImmediate  (rg, val):
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
return
}