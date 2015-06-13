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
    
    @IBAction func dependDigit(sender: UIButton)
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
    var numberStack = Array<Double>()

    @IBAction func enter()
    {
        numberStack.append(displayValue)
        isFirstDigit = true
        println("numberStack : \(numberStack)" )
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
        let operation =  sender.currentTitle!
        
        if(!isFirstDigit)
        {
            enter()
        }
        
        switch operation
        {
//        case "+" : performOperation({(op1 : Double, op2 : Double) -> Double in            
//            return op1+op2
//            })

//        case "+" : performOperation({(op1, op2) in op1+op2})
        case "+" : performOperation({$0 + $1 })
            
            
        case "−" : performOperation({$1 - $0 })
        case "×" : performOperation({$0 * $1 })
        case "÷" : performOperation({$1 / $0 })
            
        case "√" : performOperation2({sqrt($0)})
            
        default : break
        }
    }
    
    func performOperation(operation: (Double,Double)->Double)
    {
        if(numberStack.count >= 2)
        {
            displayValue = operation(numberStack.removeLast() , numberStack.removeLast())
            enter()
        }
    }
    
//    func plus(op1 : Double, op2 : Double) -> Double
//    {
//        return op1+op2
//    }
    func performOperation2(operation: Double -> Double)
    {
        if(numberStack.count >= 1)
        {
            displayValue = operation(numberStack.removeLast())
            enter()
        }
    }
    
    
    

}

