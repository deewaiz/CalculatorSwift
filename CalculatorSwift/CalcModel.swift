//
//  CalcModel.swift
//  CalculatorSwift
//
//  Created by Igor Shukyurov on 27/05/2019.
//  Copyright © 2019 Igor Shukyurov. All rights reserved.
//

import Foundation

final class Calc {
    // MARK: - Private fields
    private var firstOperand: Double = 0.0
    private var secondOperand: Double = 0.0
    private var isFirstOperandNegative: Bool = false
    private var isSecondOperandNegative: Bool = false
    private var isInputInFirstOperand: Bool = true
    private var operandStack: String = ""
    
    // MARK: - Public fields
    var operation: String = ""
    var result: String = ""
    
    // MARK: - Initializers
    // Чистый инициализатор
    init() {
        self.customInit()
    }
    
    // Инициализатор на случай выполнения цепных бинарных операций (когда не используется кнопка равно)
    init(firstOperand: String) { self.customInit(firstOperand: firstOperand) }
    
    // Инициализатор при использовании конпки равно
    init(result: String){
        if !result.isEmpty {
            self.firstOperand = result[result.index(before: result.endIndex)].isNumber ? Double(result)! : 0.0
            //if self.firstOperand.isLess(than: 0.0) { self.isFirstOperandNegative = true }
            //else { self.isFirstOperandNegative = false }
        }
    }
    
    // Костыль для чистого инициализатора
    func customInit() {
        self.firstOperand = 0.0
        self.secondOperand = 0.0
        self.isFirstOperandNegative = false
        self.isSecondOperandNegative = false
        self.operandStack = ""
        self.isInputInFirstOperand = true
    }
    
    // Второй костыль для инициализатора
    func customInit(firstOperand: String) {
        // Если результатом предыдущих вычислений была ошибка, деление на ноль или просто была прожата кнопка "Равно",
        // то вызывается стандартный инициализатор
        switch (firstOperand.isEmpty, firstOperand.contains("-")) {
        case (true, true):    print("IMPOSSUBRU!!")
        case (true, false):   self.customInit()
        case (false, true):   fallthrough
        case (false, false):  fallthrough
        default : do {
            // Проверяем, что кладем в поле firstOperand число, а не сообщение об ошибке ("Ошибка", "Деление на ноль невозможно" и т.д.)
            self.firstOperand = firstOperand[firstOperand.index(before: firstOperand.endIndex)].isNumber ? Double(firstOperand)! : 0.0
            //if self.firstOperand.isLess(than: 0.0) { self.isFirstOperandNegative = true }
            //else { self.isFirstOperandNegative = false }
            self.secondOperand = 0.0
            self.operandStack = String(self.firstOperand)
            self.isInputInFirstOperand = false
            }
        }
    }
    
    // MARK: - Private methods
    private func sum() -> String { return String(self.firstOperand + self.secondOperand) }
    private func sub() -> String { return String(self.firstOperand - self.secondOperand) }
    private func mul() -> String { return String(self.firstOperand * self.secondOperand) }
    private func div() -> String {
        if self.secondOperand == 0.0 {
            return "Ошибка"
        } else {
            return String(self.firstOperand / self.secondOperand)
        }
    }
    
    private func neg() {
        if self.isFirstOperandNegative { self.firstOperand *= -1; self.setNegative() }
        if self.isSecondOperandNegative { self.secondOperand *= -1; self.setNegative() }
    }
    
    // MARK: - Public methods
    // Установка операндов
    func setOperand(digit: String) -> String {
        switch self.isInputInFirstOperand {
        case true: do {
                self.operandStack.append(digit)
                self.firstOperand = Double(self.operandStack)!
                return String(self.firstOperand)
            }
        case false: do {
                self.operandStack.append(digit)
                self.secondOperand = Double(self.operandStack)!
                return String(self.secondOperand)
            }
        }
    }
    
    // Метод установки оператора
    func chooseOperation(symbol: String) {
            self.operation = symbol
            self.isInputInFirstOperand = false
            self.operandStack = ""
    }
    
    // Метод производящий вычисления
    func process() {
        self.neg()
        switch self.operation {
        case "+": self.result = self.sum()
        case "-": self.result = self.sub()
        case "*": self.result = self.mul()
        case "/": self.result = self.div()
        default: break
        }
    }
    
    // Метод считающий проценты
    func percent() -> String {
        if (self.operation == "*" || self.operation == "/") && !self.isInputInFirstOperand {
            self.secondOperand /= 100.0
            return String(self.secondOperand)
        }
        if (self.operation == "+" || self.operation == "-") && !self.isInputInFirstOperand {
            self.secondOperand = self.firstOperand * self.secondOperand / 100.0
            return String(self.secondOperand)
        }
        if self.operation == "" {
            self.firstOperand /= 100.0
            self.result = String(self.firstOperand)
            return String(self.firstOperand)
        }
        return ""
    }
    
    // Метод устанавливающий точку в операнд
    func setPoint() -> String {
        switch (self.isInputInFirstOperand, self.operandStack.isEmpty) {
        case (true, true): do {
                self.operandStack = "0."
                self.firstOperand = Double(self.operandStack)!
                return String(self.firstOperand)
            }
        case (true, false): do {
                self.operandStack.append(".")
                self.firstOperand = Double(self.operandStack)!
                return String(self.firstOperand)
            }
        case (false, true): do {
                self.operandStack = "0."
                self.secondOperand = Double(self.operandStack)!
                return String(self.secondOperand)
            }
        case (false, false): do {
                self.operandStack.append(".")
                self.secondOperand = Double(self.operandStack)!
                return String(self.secondOperand)
            }
        }
    }
    
    // Метод устанавливающий знак минус операнду
    func setNegative() {
        switch self.isInputInFirstOperand {
        case true: self.isFirstOperandNegative = !self.isFirstOperandNegative
        case false: self.isSecondOperandNegative = !self.isSecondOperandNegative
        }
    }
    
    // Методы выполняющие основные операции
    func doSum() -> String {
        var temp: String
        if (self.operation == "+" || self.operation == "-" || self.operation == "*" || self.operation == "/") && !self.operandStack.isEmpty {
            self.process()
            temp = self.result
            self.customInit(firstOperand: self.result)
            self.chooseOperation(symbol: "+")
        } else {
            self.process()
            temp = self.result
            self.chooseOperation(symbol: "+")
        }
        return temp
    }
    
    func doSub() -> String {
        var temp: String
        if (self.operation == "+" || self.operation == "-" || self.operation == "*" || self.operation == "/") && !self.operandStack.isEmpty {
            self.process()
            temp = self.result
            self.customInit(firstOperand: self.result)
            self.chooseOperation(symbol: "-")
        } else {
            self.process()
            temp = self.result
            self.chooseOperation(symbol: "-")
        }
        return temp
    }
    
    func doMul() -> String {
        var temp: String
        if (self.operation == "+" || self.operation == "-" || self.operation == "*" || self.operation == "/") && !self.operandStack.isEmpty {
            self.process()
            temp = self.result
            self.customInit(firstOperand: self.result)
            self.chooseOperation(symbol: "*")
        } else {
            self.process()
            temp = self.result
            self.chooseOperation(symbol: "*")
        }
        return temp
    }
    
    func doDiv() -> String {
        var temp: String
        if (self.operation == "+" || self.operation == "-" || self.operation == "*" || self.operation == "/") && !self.operandStack.isEmpty {
            self.process()
            temp = self.result
            self.customInit(firstOperand: self.result)
            self.chooseOperation(symbol: "/")
        } else {
            self.process()
            temp = self.result
            self.chooseOperation(symbol: "/")
        }
        return temp
    }
}
