//
//  ArithmeticCalculatorViewModelProtocol.swift
//  Calculator
//
//  Created by Mohamed Shemy on Sun 23 Jan, 2022.
//

import Foundation

protocol ArithmeticCalculatorViewModelProtocol: ObservableObject {
    
    var inputText: String { get set }
    var canUndo: Bool { get set }
    var canRedo: Bool { get set }
    var result: Double { get }
    var history: History<Operation> { get }
    
    func setOperator(_ op: Operator)
    func undo()
    func redo()
    func undoItem(_ item: Operation)
    func setRemote(result: Double)
}
