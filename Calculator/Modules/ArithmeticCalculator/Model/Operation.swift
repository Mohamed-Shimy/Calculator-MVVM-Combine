//
//  Operation.swift
//  Calculator
//
//  Created by Mohamed Shemy on Sun 23 Jan, 2022.
//

import Foundation

struct Operation: Identifiable {
    
    let id = UUID()
    var oprator: Operator
    var firstOperand: Double = 0
    var secondOperand: Double = 0
    var result: Double
}

extension Operation: Equatable {
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}

extension Operation: CustomStringConvertible {
    
    var description: String {
        "\(firstOperand) \(oprator.symbol) \(secondOperand) = \(result)"
    }
}
