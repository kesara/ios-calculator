//
//  ViewController.swift
//  Calculator
//
//  Created by Kesara Rathnayake on 17/10/17.
//  Copyright © 2017 fq.nz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: Properties
    @IBOutlet weak var mainTextField: UITextField!
    @IBOutlet weak var button0: UIButton!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button9: UIButton!
    @IBOutlet weak var buttonPeriod: UIButton!
    @IBOutlet weak var buttonEqual: UIButton!
    @IBOutlet weak var buttonAddition: UIButton!
    @IBOutlet weak var buttonSubstraction: UIButton!
    var valueA: Double = 0
    var valueB: Double = 0
    var currentOperator: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Actions
    @IBAction func numberPress(_ sender: UIButton) {
        // Get current text
        var currentText = ""
        if mainTextField.text != "" {
            currentText = mainTextField.text!
        }
        
        // Find text to be added
        var value = sender.currentTitle!
        if currentText == "0" && value == "0" {
            value = ""
        }
        if value == "." {
            if (currentText == "") {
                value = "0."
            } else if currentText.range(of: ".") != nil {
                value = ""
            }
        }
        
        // Update text field
        mainTextField.text = "\(currentText)\(value)"
    }
    
    @IBAction func operatorPress(_ sender: UIButton) {
        // Ignore if text field is empty
        if mainTextField.text != "" {
            let newOperator = sender.titleLabel?.text!
            if currentOperator == "" && newOperator != "=" {
                // copy current value
                valueA = Double(mainTextField.text!)!
                
                // update operator
                currentOperator = newOperator!
                
                // update display
                mainTextField.text = ""
            } else {
                // copy current value
                valueB = Double(mainTextField.text!)!
                
                // perform operation
                var result: Double = 0
                switch currentOperator {
                case "+":
                    result = valueA + valueB
                case "-":
                    result = valueA - valueB
                default:
                    result = 0
                }
                
                // update operator
                if newOperator == "=" {
                    currentOperator = ""
                } else {
                    currentOperator = newOperator!
                }
                
                // update display
                mainTextField.text = String(result)
            }
        }
    }
    
}

