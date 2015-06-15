//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by ericyu on 6/13/15.
//  Copyright (c) 2015 eric. All rights reserved.
//

import Foundation

class CalculatorBrain
{
    enum Op : Printable
    {
        case Operand(Double)
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(String, (Double,Double)->Double)
        
        var description: String
        {
            get
            {
                switch self
                {
                case .Operand(let operand):
                    return "\(operand)"
                case .UnaryOperation(let symbol, _):
                    return symbol
                case .BinaryOperation(let symbol, _):
                    return symbol
                    
                }
            }
        }
        
    }
    
    private var opStack = [Op]()
    
    private var knownOps = [String:Op]()
    
    init()
    {
        func learnOp(op:Op)
        {
            knownOps[op.description] = op
        }
        learnOp(Op.BinaryOperation("+", +))
        learnOp(Op.BinaryOperation("−", {$1-$0}))
        learnOp(Op.BinaryOperation("×", *))
        learnOp(Op.BinaryOperation("÷", {$1/$0}))
        learnOp(Op.UnaryOperation("√", sqrt))
//        knownOps["+"] = Op.BinaryOperation("+", +)
//        knownOps["−"] = Op.BinaryOperation("−", {$1-$0})
//        knownOps["×"] = Op.BinaryOperation("×", *)
//        knownOps["÷"] = Op.BinaryOperation("÷", {$1/$0})
//        knownOps["√"] = Op.UnaryOperation("√", sqrt)
        
    }
    
    func evaluate(ops:[Op]) -> (result:Double?, remaingOps:[Op])
    {
        if(!ops.isEmpty)
        {
            var remainingOps = ops;
            let op = remainingOps.removeLast()
            
            switch op
            {
            case .Operand(let operand):
                return (operand,remainingOps)
            case .UnaryOperation(_, let operation):
                let operationEvaluation = evaluate(remainingOps)
                if let operand = operationEvaluation.result
                {
                    return (operation(operand),operationEvaluation.remaingOps)
                }
            case .BinaryOperation(_, let operation):
                let op1Evaluation = evaluate(remainingOps)
                if let operand1 = op1Evaluation.result
                {
                    let op2Evaluation = evaluate(op1Evaluation.remaingOps)
                    if let operand2 = op2Evaluation.result
                    {
                        return (operation(operand1,operand2),op2Evaluation.remaingOps)
                    }
                }
            }
        }
        return (nil,ops)
    }
    
    func evaluate() -> Double?
    {
        let (result , remainder) = evaluate(opStack)
        println("\(opStack) = \(result) with \(remainder) left over")
        return result
    }
    
    func pushOperand(operand:Double) ->Double?
    {
        opStack.append(Op.Operand(operand))
        return evaluate()
    }
    
    func performOperation(symbol:String) ->Double?
    {
        if let operation = knownOps[symbol]
        {
            opStack.append(operation)
        }
        return evaluate()
    }
}
