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


}

