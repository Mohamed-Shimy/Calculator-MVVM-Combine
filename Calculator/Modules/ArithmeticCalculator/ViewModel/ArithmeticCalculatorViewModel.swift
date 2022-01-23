//
//  ArithmeticCalculatorViewModel.swift
//  Calculator
//
//  Created by Mohamed Shemy on Sun 23 Jan, 2022.
//

import Combine
import SwiftUI

final class ArithmeticCalculatorViewModel: ArithmeticCalculatorViewModelProtocol {
    
    // MARK: - Properties
    
    @Published var inputText: String = ""
    @Published var canUndo: Bool = false
    @Published var canRedo: Bool = false
    
    @Published private(set) var result: Double = 0
    @Published private(set) var history: History<Operation> = []{
        didSet {
            canUndo = history.canUndo
            canRedo = history.canRedo
        }
    }
    
    private var secondOperand: Double?
    private var currentOperator: Operator? = nil
    
    // MARK: - Methods
    
    func setOperator(_ op: Operator) {
        guard op == .equal else {
            currentOperator = op
            return
        }
        
        secondOperand = Double(inputText)
        calculateCurrentValues()
    }
    
    func undo() {
        history.undo { item in
            result = calculate(result, item.secondOperand, with: item.oprator.invert)
            return Operation(oprator: item.oprator.invert, firstOperand: result, secondOperand: item.secondOperand, result: result)
        }
    }
    
    func redo() {
        history.redo { item in
            result = calculate(result, item.secondOperand, with: item.oprator)
            return Operation(oprator: item.oprator, firstOperand: result, secondOperand: item.secondOperand, result: result)
        }
    }
    
    func undoItem(_ item: Operation) {
        history.undo(item: item) {
            result = calculate(result, item.secondOperand, with: item.oprator.invert)
            return Operation(oprator: item.oprator.invert, firstOperand: result, secondOperand: item.secondOperand, result: result)
        }
    }
    
    func setRemote(result: Double) {
        let op = findSuitableOperator(for: result)
        let secondOperand = calculate(self.result, result, with: op.invert)
        setOperator(op)
        inputText = "\(secondOperand)"
        setOperator(.equal)
    }
    
    private func findSuitableOperator(for result: Double) -> Operator {
        if result == 0 || self.result == 0 {
            return .plus
        }
        return .mul
    }
    
    // MARK: - Private Methods
    
    private func calculateCurrentValues() {
        guard let second = secondOperand,
              let op = currentOperator
        else { return }
        
        let prevResult = result
        result = calculate(result, second, with: op)
        storeCurrentItem(prevResult: prevResult)
        clearLastOperationData()
    }
    
    private func calculate(_ first: Double, _ second: Double, with op: Operator) -> Double {
        switch op {
            case .plus: return first + second
            case .minus: return first - second
            case .mul: return first * second
            case .div: return first / second
            default: return second
        }
    }
    
    private func createHistoryItemFromCurrentValues(prevResult: Double) -> Operation? {
        guard let second = secondOperand,
              let op = currentOperator else { return nil }
        return Operation(oprator: op, firstOperand: prevResult, secondOperand: second, result: result)
    }
    
    private func storeCurrentItem(prevResult: Double) {
        guard let item = createHistoryItemFromCurrentValues(prevResult: prevResult) else { return }
        addHistory(item: item)
    }
    
    private func addHistory(item: Operation) {
        history.append(item)
    }
    
    private func clearLastOperationData() {
        secondOperand = nil
        currentOperator = nil
        inputText = ""
    }
}
