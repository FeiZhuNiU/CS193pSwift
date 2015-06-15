//
//  ViewController.swift
//  Calculator
//
//  Created by ericyu on 6/12/15.
//  Copyright (c) 2015 eric. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{

    @IBOutlet weak var display: UILabel!
    
    var isFirstDigit : Bool = true
    
    var brain = CalculatorBrain()
    
    
    @IBAction func appendDigit(sender: UIButton)
    {
        let digit = sender.currentTitle!
        if(!isFirstDigit)
        {
            display.text = display.text! + digit
            
        }else{
            display.text = digit
            isFirstDigit = false
        }
    }
    

    @IBAction func enter()
    {
        isFirstDigit = true
        if let result = brain.pushOperand(displayValue)
        {
            displayValue = result
        }
        else
        {
            displayValue = 0
        }
    }
    
    var displayValue : Double{
        get{
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
            display.text = "\(newValue)"
        }
    }
    
    @IBAction func operate(sender: UIButton)
    {
        
        
        if(!isFirstDigit)
        {
            enter()
        }
        
        if let operation =  sender.currentTitle
        {
            if let result = brain.performOperation(operation)
            {
                displayValue = result
            }
            else
            {
                displayValue = 0
            }
        }
        
//        switch operation
//        {
////        case "+" : performOperation({(op1 : Double, op2 : Double) -> Double in            
////            return op1+op2
////            })
//
////        case "+" : performOperation({(op1, op2) in op1+op2})
//
//        }
    }
    

    
    
    

}

