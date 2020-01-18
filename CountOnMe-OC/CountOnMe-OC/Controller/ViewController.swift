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
    
    // Add a coma
    @IBAction func tappedComaButton(_ sender: UIButton) {

    }
    
    // Cancel the operation
    @IBAction func tappedCancelButton(_ sender: UIButton) {

    }
    
    // Enter the equal
    @IBAction func tappedEqualButton(_ sender: UIButton) {

    }
    
    // Add a model of notification observer
    private func addModelNotificationObserver(name: String) {
        let selector = Selector((name))
        NotificationCenter.default.addObserver(self, selector: selector, name: Notification.Name(rawValue: name), object: nil)
    }
}
