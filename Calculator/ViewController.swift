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
    
    var userTyping = false
    
    @IBAction func TouchMe(_ sender: UIButton) {
        
        let digit = sender.currentTitle!
        
        if userTyping{
            
            let currentDisplayByLabel = display!.text!
            display.text! = currentDisplayByLabel + digit
        }else{
            
            display.text! = digit
            userTyping = true
        }
    }
    
    var displayValue: Double{
        
        get{
            return Double(display.text!)!
        }
        
        set{
            display.text! = String(newValue)
        }
    }
    
    private var brain = CalculatorBrain()

    @IBAction func Perform(_ sender: UIButton){
        if userTyping{
            brain.setOperand(displayValue)
            userTyping = false
        }
        
        if let mathSymbol = sender.currentTitle{
            
            brain.performOperation(mathSymbol)
        }
        
        if let result = brain.result{
            displayValue = result   
        }
    }
}

