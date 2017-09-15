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
            
        }else{
            
            display2.text! = digit
            display.text! = digit
            userTyping = true
        }
        
        
        if digit == "c"{

            display.text = "0"
            display2.text = " "
            userTyping = false
            brain.clear()
        }
    }
    
    // flaoting point button "."
    @IBAction func dotAction(_ sender: Any) {
        
        if (!display.text!.contains(".")){
            display.text! = display.text! + String(".")
            userTyping = true
        }
    }

    var displayValue: Double{
        
        get{
            
            return Double(display.text!)!
        }
        set{
            
            display.text! = String(format: "%6g",newValue)
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


