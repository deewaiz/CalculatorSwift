//
//  ViewController.swift
//  CalculatorSwift
//
//  Created by Igor Shukyurov on 23/05/2019.
//  Copyright © 2019 Igor Shukyurov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Model
    var calc = Calc.init()
    
    // MARK: - Outlets
    @IBOutlet weak var resultLabel: UILabel!
    
    // MARK: - Lyfecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        calc.setOperand(digit: "1")
        calc.setOperand(digit: "3")
        print(calc.firstOperand)
        
        calc.chooseOperation(symbol: "+")
        
        calc.setOperand(digit: "2")
        calc.setOperand(digit: "2")
        print(calc.firstOperand)
        print(calc.secondOperand)
        
        print(calc.process())
        
        
        
        
        calc = Calc.init(firstOperand: calc.process())
        print(calc.firstOperand)
        print(calc.secondOperand)
        
        calc.chooseOperation(symbol: "/")
        
        calc.setOperand(digit: "0")
        calc.setOperand(digit: "0")
        print(calc.secondOperand)
        
        print(calc.process())
        */
    }
    
    // MARK: - Button actions
    @IBAction func acAction(_ sender: Any)    { calc = Calc.init(); resultLabel.text?.removeAll() }
    @IBAction func zeroAction(_ sender: Any)  { resultLabel.text = calc.setOperand(digit: "0") }
    @IBAction func oneAction(_ sender: Any)   { resultLabel.text = calc.setOperand(digit: "1") }
    @IBAction func twoAction(_ sender: Any)   { resultLabel.text = calc.setOperand(digit: "2") }
    @IBAction func threeAction(_ sender: Any) { resultLabel.text = calc.setOperand(digit: "3") }
    @IBAction func fourAction(_ sender: Any)  { resultLabel.text = calc.setOperand(digit: "4") }
    @IBAction func fiveAction(_ sender: Any)  { resultLabel.text = calc.setOperand(digit: "5") }
    @IBAction func sixAction(_ sender: Any)   { resultLabel.text = calc.setOperand(digit: "6") }
    @IBAction func sevenAction(_ sender: Any) { resultLabel.text = calc.setOperand(digit: "7") }
    @IBAction func eightAction(_ sender: Any) { resultLabel.text = calc.setOperand(digit: "8") }
    @IBAction func nineAction(_ sender: Any)  { resultLabel.text = calc.setOperand(digit: "9") }
    
    @IBAction func pointAction(_ sender: Any) { resultLabel.text = calc.setPoint() }//setOperand(digit: ".") }
    
    @IBAction func sumAction(_ sender: Any) { resultLabel.text = calc.doSum() }
    @IBAction func subAction(_ sender: Any) { resultLabel.text = calc.doSub() }
    @IBAction func mulAction(_ sender: Any) { resultLabel.text = calc.doMul() }
    @IBAction func divAction(_ sender: Any) { resultLabel.text = calc.doDiv() }
    
    @IBAction func negationAction(_ sender: Any) { calc.setNegative(); resultLabel.text?.insert("-", at: resultLabel.text!.startIndex) }
    @IBAction func percentAction(_ sender: Any) { resultLabel.text = calc.percent() }
    
    @IBAction func eqAction(_ sender: Any) {
        calc.process()
        resultLabel.text = calc.result
        calc = Calc.init(result: calc.result)
    }

}

