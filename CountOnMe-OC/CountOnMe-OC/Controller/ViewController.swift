//
//  ViewController.swift
//  CountOnMe-OC
//
//  Created by Melissa GS on 18/01/2020.
//  Copyright © 2020 Goglow. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    
    var calc = SimpleCalc()
    
    var elements: [String] {
        return textView.text.split(separator: " ").map { "\($0)" }
    }
    // Add a model of notification observer
    private func addModelNotificationObserver(name: String) {
        let selector = Selector((name))
        NotificationCenter.default.addObserver(self, selector: selector, name: Notification.Name(rawValue: name), object: nil)
    }
    
    // Error check computed variables
    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-"
    }
    
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-"
    }
    
    var expressionHaveResult: Bool {
        return textView.text.index(of: "=") != nil
    }
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        addModelNotificationObserver(name: "operatorSet")
        addModelNotificationObserver(name: "correctExpression")
        addModelNotificationObserver(name: "newCalculation")
    }
    
    // Error alert if an operator is already set
    func operatorSet() {
        let alertVC = UIAlertController(title: "Zero!", message: "An operator is already set!", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    
    // Error alert if an incorrect expression is enter
    func correctExpression() {
        let alertVC = UIAlertController(title: "Zero!", message: "Enter a correct expression!", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    
    // Error alert for start a new calculation
    func newCalculation() {
        let alertVC = UIAlertController(title: "Zero!", message: "Start a new calculation!", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    
    // Actions
    // Enter the numbers
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        if expressionHaveResult {
            textView.text = ""
        }
        textView.text.append(numberText)
    }
    
    // Take an addition
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        if canAddOperator {
            textView.text.append(" + ")
        } else {
            operatorSet()
        }
    }
    
    // Take a substraction
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        if canAddOperator {
            textView.text.append(" - ")
        } else {
            operatorSet()
        }
    }
 
    // Take a multiplication
    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        if canAddOperator {
            textView.text.append(" x ")
        } else {
            operatorSet()
        }
    }
    
    // Take a division
    @IBAction func tappedDivisionButton(_ sender: UIButton) {
        if canAddOperator {
            textView.text.append(" ÷ ")
        } else {
            operatorSet()
        }
    }
    
    // Cancel the operation
    @IBAction func tappedCancelButton(_ sender: UIButton) {
        
    }
    
    // Enter the equal
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        guard expressionIsCorrect else {
            let alertVC = UIAlertController(title: "Zero!", message: "Enter a correct expression!", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        
        guard expressionHaveEnoughElement else {
            let alertVC = UIAlertController(title: "Zero!", message: "Start a new calculation!", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        
        // Create local copy of operations
        var operationsToReduce = elements
        
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            let left = Int(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Int(operationsToReduce[2])!
            
            let result: Int
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            case "x": result = left * right
            case "÷": result = left / right
            default: fatalError("Unknown operator!")
            }
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result)", at: 0)
        }
        textView.text.append(" = \(operationsToReduce.first!)")
    }
}
