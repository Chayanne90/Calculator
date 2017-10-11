//
//  ViewController.swift
//  Calculator
//
//  Created by Chayanne on 8/20/17.
//  Copyright © 2017 Chayanne. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet var display: UILabel!
    @IBOutlet var display2: UILabel!
    var userTyping = false
    
    @IBAction func TouchMe(_ sender: UIButton) {
        let digit = sender.currentTitle!
        
        if userTyping{
            let currentDisplayByLabel = display!.text!
            display.text! = currentDisplayByLabel + digit
            display2.text! = currentDisplayByLabel + digit
            
        }else {
            display.text! = digit
            display2.text!  = digit
            userTyping = true
        }
        
        if digit == "c"{
            display.text = "0"
            display2.text = " "
            brain.clear()
            userTyping = false
        }
        if digit == "."{         // " . " button better solution
            display.text! = "."
            display.text = "0\(digit)"
            userTyping = true
        }
    }
    
    @IBAction func Undo(_ sender: UIButton) {
        
        if userTyping, var text = display.text{
            text.remove(at: (text.index(before: (text.endIndex))))
            display.text! = text
        }
    }
    
    var displayValue: Double{
        get{
            return Double(display.text!)!
        }
        set{
            display.text!  = String(format: "%6g",newValue)
            display2.text! = String(format: "%6g")
        }
    }
    
    private var brain = CalculatorBrain()
    
    @IBAction func Perform(_ sender: UIButton){
        if userTyping{
            brain.setOperand(displayValue)
            userTyping = false
        }
        if  let mathSymbol = sender.currentTitle{
            brain.performOperation(mathSymbol)
            display2.text = brain.description
        }
        
        if let result = brain.result{
            displayValue = result
        }
        display2.text! = brain.description
    }
}


