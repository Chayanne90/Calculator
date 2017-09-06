//
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
        case unaryOperation
    }
    
    private var operations: Dictionary<String,Operation>=[
    
        "π": Operation.constant(Double.pi),
        "e": Operation.constant(M_E),
        "√": Operation.unaryOperation, //sqrt
        "cos": Operation.unaryOperation //cos
        
    
    
    ]
    
    mutating func performOperation( _ symbol: String){
        
        if let operation =  operations[symbol]{
            
            switch operation {
            case .constant(<#T##Double#>):
                break
            case .unaryOperation:
                break
            }
        
           
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


