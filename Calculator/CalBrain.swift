
//  CalBrain.swift
//  Calculator
//
//  Created by Chayanne on 8/30/17.
//  Copyright © 2017 Chayanne. All rights reserved.
//

import Foundation

struct CalculatorBrain {
    
    private var accumulator: Double?
    var array:[String]  = [ ]
    
    private enum Operation {
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double,Double) -> Double)
        case equals
    }
    
    private var operations: Dictionary<String,Operation> = [
        "π": Operation.constant(Double.pi),
        "e": Operation.constant(M_E),
        "√": Operation.unaryOperation(sqrt),
        "cos": Operation.unaryOperation(cos),
        "sin": Operation.unaryOperation(sin),
        "tan" : Operation.unaryOperation(tan),
        "x²" : Operation.binaryOperation({pow($0,$1)}),
        "x³" : Operation.unaryOperation({ pow($0, 3)}),
        "x⁻¹" : Operation.unaryOperation({ 1 / $0 }),
        "10ˣ" : Operation.unaryOperation({ pow(10, $0)}),
        "ln" : Operation.unaryOperation(log),
        "±" : Operation.unaryOperation({-$0}),// closures
        "×" : Operation.binaryOperation({$0 * $1}),
        "÷" : Operation.binaryOperation({$0 / $1}),
        "+" : Operation.binaryOperation({$0 + $1}),
        "-" : Operation.binaryOperation({$0 - $1}),
        "=" : Operation.equals,
        ]
    
    mutating func performOperation( _ symbol: String){
        if let operation =  operations[symbol]{
            switch operation {
                
            case .constant(let Value):
                array.append(symbol)
                accumulator = Value
            case .unaryOperation(let function):
                if accumulator != nil{
                    performPendingBinaryOperation()
                    accumulator = function(accumulator!)
                }
            case .binaryOperation(let function):
                
                if accumulator != nil{
                    performPendingBinaryOperation()
                    pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: accumulator!)
                    array.append(symbol)
                    accumulator = nil
                }
            case .equals:
                performPendingBinaryOperation()
                array.append(String("="))
            }
        }
    }
    
    // clear funciton "c"
    mutating func clear(){
        accumulator = 0
        pendingBinaryOperation = nil
        array.removeAll()
        
    }
    
    var resultPending: Bool{
        get{
            if pendingBinaryOperation != nil{
                return true
            }
            return false
        }
    }
    
    var description: String{
        mutating get{
            if resultPending {
                return array.joined(separator:"  ") + "..."
            }
            return array.joined(separator:"  ")
        }
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
        array.append(String(operand))
    }
    
    var result: Double?{
        get{
            return accumulator
        }
    }
}


