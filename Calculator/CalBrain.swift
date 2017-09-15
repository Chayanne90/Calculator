
//  CalBrain.swift
//  Calculator
//
//  Created by Chayanne on 8/30/17.
//  Copyright © 2017 Chayanne. All rights reserved.
//

import Foundation

struct CalculatorBrain {
    
    private var accumulator: Double?
    
    private enum Operation {
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double,Double) -> Double)
        case equals
        case dot
        
    }
    
    private var operations: Dictionary<String,Operation> = [
        "π": Operation.constant(Double.pi),
        "e": Operation.constant(M_E),
        "√": Operation.unaryOperation(sqrt),
        "cos": Operation.unaryOperation(cos),
        "sin": Operation.unaryOperation(sin),
        "tan" : Operation.unaryOperation(tan),
        "x²" : Operation.binaryOperation(pow),
        "±" : Operation.unaryOperation({-$0}),// closures
        "×" : Operation.binaryOperation({$0 * $1}),
        "÷" : Operation.binaryOperation({$0 / $1}),
        "+" : Operation.binaryOperation({$0 + $1}),
        "-" : Operation.binaryOperation({$0 - $1}),
        "=" : Operation.equals,
        "." : Operation.dot,
        
        ]
    
    mutating func performOperation( _ symbol: String){
        
        if let operation =  operations[symbol]{
            
            switch operation {
                
            case .constant(let Value):
                accumulator = Value
            case .unaryOperation(let function):
                if accumulator != nil{
                    accumulator = function(accumulator!)
                }
            case .binaryOperation(let function):
                if accumulator != nil{
                    pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: accumulator!)
                    accumulator = nil
                }
            case .equals:
                performPendingBinaryOperation()
            default:break
            }
        }
    }
    
    // clear funciton "c"
    mutating func clear(){
        accumulator = nil
        pendingBinaryOperation = nil
    }
    

        
    
    private mutating func performPendingBinaryOperation(){
        
        if pendingBinaryOperation != nil && accumulator != nil{
            accumulator = pendingBinaryOperation!.perform(with: accumulator!)
            pendingBinaryOperation = nil
        }
    }
    
    private var pendingBinaryOperation: PendingBinaryOperation?
    
    private struct PendingBinaryOperation{
        
        let function: (Double, Double) -> Double
        let firstOperand: Double
        func perform(with secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
            
        }
        
    }
    mutating func setOperand(_ operand: Double){
        accumulator = operand
    }
    var result: Double?{
        get{
            
            return accumulator
        }
        
    }
}


