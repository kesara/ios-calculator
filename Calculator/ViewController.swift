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
    @IBOutlet weak var textFieldMain: UITextField!
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
    @IBOutlet weak var buttonPlusMinus: UIButton!
    @IBOutlet weak var buttonEqual: UIButton!
    @IBOutlet weak var buttonAddition: UIButton!
    @IBOutlet weak var buttonSubstraction: UIButton!
    @IBOutlet weak var buttonMultiplication: UIButton!
    @IBOutlet weak var buttonDivision: UIButton!
    @IBOutlet weak var buttonAllCancel: UIButton!
    @IBOutlet weak var textViewHistory: UITextView!
    
    var valueA: Double = 0
    var valueB: Double = 0
    var currentOperator: String = ""
    var refreshTextField: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Actions
    @IBAction func allCancel(_ sender: UIButton) {
        // reset all variables
        valueA = 0
        valueB = 0
        currentOperator = ""
        refreshTextField = true
        
        // update text field
        textFieldMain.text = "0"
    }
    
    @IBAction func numberPress(_ sender: UIButton) {
        // find text to be added
        var value = sender.currentTitle!
        // get current text
        var currentText = ""
        
        // value shourld be refreshed?
        if textFieldMain.text != "0" && (!refreshTextField  || value == "±") {
            currentText = textFieldMain.text!
        }
        
        // zero
        if currentText == "0" && value == "0" {
            value = ""
        }
        
        // period
        if value == "." {
            if currentText == "" {
                value = "0."
            } else if currentText.range(of: ".") != nil {
                value = ""
            }
        }
        
        // plus/minus
        if value == "±" {
            value = ""
            if currentText != "" {
                if currentText.hasPrefix("-") {
                    let start = currentText.startIndex
                    let end = currentText.index(after: start)
                    currentText = currentText.replacingOccurrences(of: "-", with: "", range: start..<end)
                } else {
                    currentText = "-\(currentText)"
                }
            }
        }
        
        // update text field
        refreshTextField = false
        textFieldMain.text = "\(currentText)\(value)"
    }
    
    @IBAction func operatorPress(_ sender: UIButton) {
        // ignore if text field is empty
        if textFieldMain.text != "" {
            // get new operator
            let newOperator = sender.titleLabel?.text!
            // refresh text field
            refreshTextField = true
            
            if currentOperator == "" && newOperator != "=" {
                // copy current value
                valueA = Double(textFieldMain.text!)!
                
                // update operator
                currentOperator = newOperator!
            } else {
                // copy current value
                valueB = Double(textFieldMain.text!)!
                
                // perform operation
                var result: Double = 0
                switch currentOperator {
                case "+":
                    result = valueA + valueB
                case "-":
                    result = valueA - valueB
                case "×":
                    result = valueA * valueB
                case "÷":
                    result = valueA / valueB
                default:
                    result = valueB
                }
                
                if currentOperator != "" {
                    // construct history entry
                    let historyEntry: String = "\(valueA) \(currentOperator) \(valueB) = \(result)\n"
                    // update history
                    textViewHistory.text! += historyEntry
                }
                
                // update operator & values
                currentOperator = ""
                valueA = 0
                valueB = 0
                
                if newOperator != "=" {
                    valueA = result
                    currentOperator = newOperator!
                }
                
                // update text field
                textFieldMain.text = String(result)
            }
        }
    }
    
}

